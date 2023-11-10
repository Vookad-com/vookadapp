import 'package:Vookad/config/location.dart';
import 'package:Vookad/models/searchAddr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  final box = Hive.box<SearchAddr>('searchAddrBox');

  @override
  void initState() {
    super.initState();
    locowatch();
  }

  void locowatch(){
    final locolisten = box.watch();
    locolisten.listen((event) {
         setState(() {

         });
    });
  }

  Future<SearchAddr> fetchLoco() async {
    try {


      SearchAddr? addr = box.get('current');
      if (addr != null) {
        return addr;
      }
    } catch (e) {
      print('Error accessing Hive box: $e');
    }

    try {
      List<double> loco = await getLoco();
      final response = await http.get(Uri.parse(
          'https://api.mapbox.com/geocoding/v5/mapbox.places/${loco[1]},${loco[0]}.json?access_token=pk.eyJ1Ijoic2FoaWxjb2RlcjEiLCJhIjoiY2xhejYyOGdvMGlkajN3cnpnZXhvMGN3MSJ9.3kZ0cQL6qD9_JrFW557_0w'));
      final Map<String, dynamic> data = json.decode(response.body);
      String place = data["features"][0]["text"] ?? "";
      String placeName = data["features"][0]["place_name"] ?? "";
      return SearchAddr(placeName: placeName, place: place, lng: loco[1], lat: loco[0]);
    } catch (e) {
      print('Error fetching location information: $e');
      // Handle the error or return a default value
      return SearchAddr(placeName: 'Ghatikia', place: 'OUTR', lng: 85.8429385, lat: 20.2661435);
    }

  }

  @override
  Widget build(BuildContext context) {

    return Row(
            children: <Widget>[
              Expanded(
                flex:8,
                child: GestureDetector(
                  onTap: (){context.push('/address');},
                  child: SizedBox(
                  height: 60,
                  child:Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 5.0),
                  child: FutureBuilder(
                    future: fetchLoco(),
                    builder: (context,snapshot){
                      if(snapshot.hasData){
                        SearchAddr? addr = snapshot.data;
                        return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:<Widget>[
                        Row(
                          children: <Widget>[
                            SvgPicture.asset(
                              "assets/Map.svg",
                              width: 30, // Adjust the width of the SVG image
                              height: 30, // Adjust the height of the SVG image
                            ),
                            const SizedBox(width: 8),
                            Expanded(child: Text(
                              addr?.place ?? "",
                              style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w600,),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            )),
                            const SizedBox(width: 8),
                            const Icon(Icons.keyboard_arrow_down),
                          ],
                        ),
                        // const SizedBox(height: 8), // Add spacing between the two rows
                        Text(
                          addr?.placeName ?? "",
                          style: const TextStyle(fontSize: 16),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],);
                      }
                      return const SizedBox(
                        width: 50,
                      );
                    },
                  ),
                    ),
                ),
                ),
                ),
              Expanded(
                flex:3,
                child: GestureDetector(
                      // onTap: _toggle,
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 200),
                        opacity: 1.0,
                        child: Container(
                          height: 35,
                          decoration: BoxDecoration(
                            color: HexColor('#0CBC8B'), // Replace with your hex color code
                            borderRadius: BorderRadius.circular(60.0), // Set the border radius
                          ),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child:SvgPicture.asset(
                                    "assets/grass.svg",
                                    width: 25, // Adjust the width of the SVG image
                                    height: 25, // Adjust the height of the SVG image
                                  ),
                              )),
                              const Expanded(
                                  flex: 1,
                                  child: Text("Veg",))
                            ],
                          ),
                      ),
                      ),
                    ),
              ),
              // const SizedBox(width: 5),
              Expanded(
                  flex:2,
                  child: GestureDetector(
                    onTap: () {
                      context.push('/profile');
                    },
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60.0), // Set the border radius
                      ),
                      child: Image.asset('assets/dummy/profile.png')
                    ),
                ),
              )
            ],
          );
  }
}
