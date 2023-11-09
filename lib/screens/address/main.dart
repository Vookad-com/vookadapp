import 'dart:async';
import 'dart:convert';

import 'package:Vookad/config/colors.dart';
import 'package:Vookad/models/address.dart';
import 'package:Vookad/models/searchAddr.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

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
  List<SearchAddr> srhresults = [];

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<List<double>> getLoco() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return [20.4, 85.7];
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return [20.4, 85.7];
      }
    }

    locationData = await location.getLocation();
    return [locationData.latitude?? 20.4, locationData.longitude?? 85.7];
      }

  void _mapSearch(String searchText) async {
    List<double> loco = await getLoco();
    const String bearerToken = '91613684-c495-4383-a2e4-e028382ccbe2';
    final response = await http.get(Uri.parse('https://api.mapbox.com/geocoding/v5/mapbox.places/$searchText.json?proximity=${loco[1]},${loco[0]}&access_token=sk.eyJ1Ijoic2FoaWxjb2RlcjEiLCJhIjoiY2xvcW5tZTlxMGxzZTJqcGVjbzk5aTg1dCJ9.8DxH0a8mSl3ptAJvWZGbqA'));

    if (response.statusCode == 200) {
      srhresults.clear();
      final Map<String, dynamic> data = json.decode(response.body);
      if (data.containsKey("features")) {
        List<dynamic> suggestedLocations = data["features"];

        for (var item in suggestedLocations) {
          if (item is Map<String, dynamic>) {
            SearchAddr inst = SearchAddr(
              placeName: item["place_name"],
              lng: item["center"][0],
              lat: item["center"][1]
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
          var query = QueryOptions(document: gql(getAddress));
          final QueryResult result = await client.query(query);
          if (result.hasException) {
            throw Exception('Graphql error');
          } else {
            List<AddressInst> addresses = [];
            if (result.data?["getUser"]["addresses"] != null && result.data?["getUser"]["addresses"] is List) {
              for (var item in result.data?["getUser"]["addresses"]) {
                AddressInst inst = AddressInst(label: item["label"][0], area: item["area"], building: item["building"], landmark: item["landmark"], location:item["location"]["coordinates"]);
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
                      suffixIcon: IconButton(
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
              child: const InkWell(
                child: Padding(
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
              child: const InkWell(
                child: Padding(
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
                                        width: 300, // Set your specific width here
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
                          child: InkWell(
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        children: [
                                          const Icon(Icons.place, color: AppColors.bgPrimary,),
                                          Text(e.label),
                                        ],
                                      ),
                                      const SizedBox(width: 10,),
                                      Text("${e.building}, ${e.area}, ${e.landmark}", style: const TextStyle(fontSize: 14),)
                                    ],
                                  ),
                                  const Icon(Icons.arrow_right_rounded)
                                ],
                              ),
                            ),
                          ),
                        );
                      } ).toList(),
                    );
                  }
                  if(snapshot.hasError){
                    return const SizedBox();
                  }
                  return const CircularProgressIndicator(strokeWidth: 2,color: AppColors.bgPrimary,);
                }
            )

                ],
              ),
            ),
        ),
    );
  }
}
