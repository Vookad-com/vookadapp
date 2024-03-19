import 'dart:async';
import 'dart:convert';

import 'package:Vookad/config/colors.dart';
import 'package:Vookad/config/location.dart';
import 'package:Vookad/models/address.dart';
import 'package:Vookad/models/searchAddr.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import 'package:graphql_flutter/graphql_flutter.dart';
import '../../graphql/graphql.dart';
import '../../graphql/userquery.dart';

class Address extends StatefulWidget {
  const Address({super.key});

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  final TextEditingController _textController = TextEditingController();
  late Timer _debounce = Timer(const Duration(seconds: 1), () { });
  late Future<List<double>> location;
  List<SearchAddr> srhresults = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    location = getLoco();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _mapSearch(String searchText) async {
    List<double> loco = await location;
    const String bearerToken = '91613684-c495-4383-a2e4-e028382ccbe2';
    final response = await http.get(Uri.parse('https://api.mapbox.com/geocoding/v5/mapbox.places/$searchText.json?proximity=${loco[1]},${loco[0]}&access_token=pk.eyJ1Ijoic2FoaWxjb2RlcjEiLCJhIjoiY2xhejYyOGdvMGlkajN3cnpnZXhvMGN3MSJ9.3kZ0cQL6qD9_JrFW557_0w'));

    if (response.statusCode == 200) {
      srhresults.clear();
      final Map<String, dynamic> data = json.decode(response.body);
      if (data.containsKey("features")) {
        List<dynamic> suggestedLocations = data["features"];

        for (var item in suggestedLocations) {
          if (item is Map<String, dynamic>) {
            SearchAddr inst = SearchAddr(
              placeName: item["place_name"],
              place: item["text"],
              lng: item["center"][0],
              lat: item["center"][1],
              pincode: "",
            );
            srhresults.add(inst);
          }
        }
        setState(() {
          srhresults = srhresults;
        });
      }
    } else {
      // Handle an error
      print('API Request Failed');
    }
  }

  void _onTextChanged(String text) {
    if (_debounce.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(seconds: 1), () {
      _mapSearch(text);
    });
  }

  Future<List<AddressInst>> fetchAddress() async {
        try {
          var query = QueryOptions(document: gql(getAddress),fetchPolicy: FetchPolicy.noCache);
          final QueryResult result = await client.query(query);
          if (result.hasException) {
            throw Exception('Graphql error');
          } else {
            List<AddressInst> addresses = [];
            if (result.data?["getUser"]["addresses"] != null && result.data?["getUser"]["addresses"] is List) {
              for (var item in result.data?["getUser"]["addresses"]) {
                AddressInst inst = AddressInst(id: item["_id"],label: item["label"][0], area: item["area"], building: item["building"], landmark: item["landmark"], location:item["location"]["coordinates"], pincode: item["pincode"]);
                addresses.add(inst);
              }
            }
            return addresses;
          }
        } catch(e){
          print(e);
          throw Exception("Error in fetching");
        }
      }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF6FBFF),
        body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView(
          children: <Widget>[
            const SizedBox(width: 10, height: 5,),
            Row(
              children: [
                InkWell(
                  onTap: () {
                      context.pop();
                    },
                  child: const Padding(
                    padding: EdgeInsets.all(5),
                    child: Icon(Icons.keyboard_arrow_down),
                  ),
                ),
                const SizedBox(width: 10),
                const Text('Select a location', style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,),)
              ],
            ),
            TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.white,
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      hintText: 'Search places, pincode, etc',
                      prefixIcon: const Icon(Icons.search_rounded, color: AppColors.bgPrimary,),
                      suffixIcon: _textController.text == ""?const SizedBox():IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    setState(() {
                                      _textController.clear();
                                       FocusScope.of(context).unfocus();
                                       srhresults.clear();
                                    });
                                  },
                                ),
                      hintStyle: const TextStyle(color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: AppColors.white, width: 1),
                          borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: AppColors.white, width: 1),
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    onChanged: _onTextChanged,
                    // controller: phoneNumberController,
                    style: const TextStyle(color: AppColors.black, fontSize: 16),
                  ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              padding: const EdgeInsets.symmetric(vertical: 5.0),// Vertical margin
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12.0),
                ),
              child: InkWell(
                onTap: () async {
                  List<double> loco = await location;
                  context.push("/address/map/${loco[1]}/${loco[0]}");
                },
                child: const Padding(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.gps_fixed_rounded, color: AppColors.bgPrimary,),
                          SizedBox(width: 10,),
                          Text("Use current location", style: TextStyle(fontSize: 14),)
                        ],
                      ),
                      Icon(Icons.arrow_right_rounded)
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              padding: const EdgeInsets.symmetric(vertical: 5.0),// Vertical margin
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12.0),
                ),
              child: InkWell(
                onTap: () async {
                  List<double> loco = await location;
                  context.push("/address/setaddr/${loco[1]}/${loco[0]}/ ");
                },
                child: const Padding(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.add, color: AppColors.bgPrimary,),
                          SizedBox(width: 10,),
                          Text("Add Address", style: TextStyle(fontSize: 14),)
                        ],
                      ),
                      Icon(Icons.arrow_right_rounded)
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
                visible: srhresults.isNotEmpty,
                child: Column(
                      children: srhresults.map((e){
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: InkWell(
                            onTap: () {
                                  context.push("/address/map/${e.lng}/${e.lat}");
                                },
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.place, color: AppColors.bgPrimary),
                                      const SizedBox(width: 10),
                                      SizedBox(
                                        width: 280, // Set your specific width here
                                        child: Text(
                                          e.placeName,
                                          style: const TextStyle(fontSize: 14),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      )
                                    ],
                                  ),
                                  const Icon(Icons.arrow_right_rounded)
                                ],
                              ),
                            ),
                          ),
                        )
                        ;
                      } ).toList(),
                    ),),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: const Text("Saved addresses", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),),
            ),
            FutureBuilder(
                future: fetchAddress(),
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    return Column(
                      children: snapshot.data!.map((e){
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          padding: const EdgeInsets.symmetric(vertical: 5.0),// Vertical margin
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(12.0),
                            ),
                          child: Column(
                            children: [
                              InkWell(
                            onTap: () async {
                              SearchAddr addr = SearchAddr(placeName: "${e.building}, ${e.area}, ${e.landmark}", place: e.label, pincode: e.pincode, lng: double.tryParse((e.location).elementAt(0)?.toString() ?? '0.0') ?? 0.0,lat: double.tryParse((e.location).elementAt(1)?.toString() ?? '0.0') ?? 0.0);
                              var box = Hive.box<SearchAddr>('searchAddrBox');
                              await box.put('current', addr);
                              context.go("/home");
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        const Icon(Icons.place, color: AppColors.bgPrimary,),
                                        Text(e.label),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10,),
                                  Expanded(
                                    flex:3,
                                    child: Text("${e.building}, ${e.area}, ${e.landmark}", style: const TextStyle(fontSize: 14),overflow: TextOverflow.ellipsis,
                                      maxLines: 1,),
                                  ),
                                  const Icon(Icons.arrow_right_rounded)
                                ],
                              ),
                            ),
                          ),
                          Row(children: [
                            const SizedBox(width: 50,),
                            InkWell(
                              onTap:(){
                                context.push("/address/setaddr/${e.location[0]}/${e.location[1]}/${e.id}");
                              },
                              child: const Icon(Icons.edit, size: 30, color: AppColors.bgPrimary,),
                            ),
                            InkWell(
                              onTap:() async {
                                var query = MutationOptions(document: gql(delAddr), variables: {"delAddrId": e.id});
                                try{
                                  final QueryResult result = await client.mutate(query);
                                  setState(() {

                                  });
                                } catch(e){
                                  print(e);
                                }
                              },
                              child: const Icon(Icons.delete_rounded, size: 30, color: AppColors.bgPrimary,),
                            )
                          ],),
                            ],
                          ),
                        );
                      } ).toList(),
                    );
                  }
                  if(snapshot.hasError){
                    return const SizedBox();
                  }
                  return Container(
                    width: 20,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height:20,
                    child:const CircularProgressIndicator(strokeWidth: 1,color: AppColors.bgPrimary),
                  );
                }
            )

                ],
              ),
            ),
        ),
    );
  }
}
