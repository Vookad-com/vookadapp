import 'package:Vookad/models/searchAddr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/visibility.dart' as flutterVisibility;
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:Vookad/config/colors.dart';
import 'package:Vookad/config/location.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class MapInput extends StatefulWidget {
  final double lng;
  final double lat;
  final void Function(BuildContext, SearchAddr) backtoHome;
  const MapInput({super.key, required this.lng,required this.lat, required this.backtoHome});
  @override
  State<MapInput> createState() => _MapInputState();
}

class _MapInputState extends State<MapInput> {
  final accessToken = "pk.eyJ1Ijoic2FoaWxjb2RlcjEiLCJhIjoiY2xhejYyOGdvMGlkajN3cnpnZXhvMGN3MSJ9.3kZ0cQL6qD9_JrFW557_0w";
  List<double>? loco;
  late Future<List<double>> location;
  MapboxMap? mapboxMap;
  String place = "";
  String placeName = "";
  String pincode = "751029";
  late Timer _debounce = Timer(const Duration(seconds: 1), () { });
  final TextEditingController _textController = TextEditingController();
  late Timer _debounce1 = Timer(const Duration(seconds: 1), () { });
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
    final response = await http.get(Uri.parse('https://api.mapbox.com/geocoding/v5/mapbox.places/$searchText.json?limit=3&proximity=${loco[1]},${loco[0]}&access_token=pk.eyJ1Ijoic2FoaWxjb2RlcjEiLCJhIjoiY2xhejYyOGdvMGlkajN3cnpnZXhvMGN3MSJ9.3kZ0cQL6qD9_JrFW557_0w'));

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
    if (_debounce1.isActive ?? false) _debounce1.cancel();
    _debounce1 = Timer(const Duration(seconds: 1), () {
      _mapSearch(text);
    });
  }

  Future<List<String>> getInfo(double lng,double lat) async {
    final response = await http.get(Uri.parse('https://api.mapbox.com/geocoding/v5/mapbox.places/$lng,$lat.json?access_token=pk.eyJ1Ijoic2FoaWxjb2RlcjEiLCJhIjoiY2xhejYyOGdvMGlkajN3cnpnZXhvMGN3MSJ9.3kZ0cQL6qD9_JrFW557_0w'));
    final Map<String, dynamic> data = json.decode(response.body);
    final List<dynamic> context = data['features'][0]['context'];
      for (var item in context) {
        if (item['id'].contains('postcode')) {
          pincode =  item['text'];
          break;
        }
      }
    String name = data["features"][0]["text"] ?? "";
    String place = data["features"][0]["place_name"] ?? "";
    return [name,place];
  }
  _onMapCreated(MapboxMap mapboxMap) async {
    this.mapboxMap = mapboxMap;
    mapboxMap.location.updateSettings(LocationComponentSettings(
      enabled: true,
    ));
    loco = await location;
  }

  _onCameraChangeListener(data) async {
    // print("CameraChangedEventData: begin: ${data.begin}, end: ${data.end}");
    print("oggy");
    if (_debounce.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(seconds: 1), () async {
      var cam = await mapboxMap?.getCameraState();
      double lng = double.tryParse((cam?.center["coordinates"] as List<dynamic>?)?.elementAt(0)?.toString() ?? '0.0') ?? 0.0;
      double lat = double.tryParse((cam?.center["coordinates"] as List<dynamic>?)?.elementAt(1)?.toString() ?? '0.0') ?? 0.0;
      List<String> response = await getInfo(lng, lat);
      setState(() {
        place = response[0];
        placeName = response[1];
      });
    });

    // if()
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
            MapWidget(
              onMapCreated:  _onMapCreated,
              resourceOptions: ResourceOptions(accessToken: accessToken),
              onCameraChangeListener: _onCameraChangeListener,
              cameraOptions: CameraOptions(
                                center: Point(coordinates: Position(widget.lng, widget.lat)).toJson(),
                                zoom: 12.0),
          ),
          Center(
            child: Transform.translate(
                offset: const Offset(0,-24),
                child: Image.asset("assets/location.png"),
            )
          ),
          Positioned(child: SafeArea(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
            child: Column(
              children: [
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
                  flutterVisibility.Visibility(
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
                                          mapboxMap?.setCamera(CameraOptions(
                                            center: Point(coordinates: Position(e.lng, e.lat)).toJson(),
                                            zoom: 12.0));
                                          //  setState(() {
                                             _textController.clear();
                                             FocusScope.of(context).unfocus();
                                             srhresults.clear();
                                          //  });
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
                          ),)
              ],
            ),
          ),
          )),
          Align(
            alignment: Alignment.bottomCenter,
            child: InkWell(
            onTap: (){
              mapboxMap?.setCamera(
                  CameraOptions(
                    center: Point(coordinates: Position(loco![1], loco![0])).toJson(),
                    zoom: 12.0)
              );
            },
            child: Container(
              margin: const EdgeInsets.all(10),
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: AppColors.white
              ),
              padding: const EdgeInsets.all(10),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("use current location", style: TextStyle(color: AppColors.bgPrimary),),
                   Icon(Icons.location_on, color: AppColors.bgPrimary,)
                ],
              ),
            ),
          ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(10),
        height: 110,
        child: Column(
          children: [
            Text(place, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)
              ,overflow: TextOverflow.ellipsis,
              maxLines: 1,),
            Text(placeName, style: const TextStyle(fontSize: 10),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,),
            ElevatedButton(
                onPressed: () async {
                  var cam = await mapboxMap?.getCameraState();
                  double lng = double.tryParse((cam?.center["coordinates"] as List<dynamic>?)?.elementAt(0)?.toString() ?? '0.0') ?? 0.0;
                  double lat = double.tryParse((cam?.center["coordinates"] as List<dynamic>?)?.elementAt(1)?.toString() ?? '0.0') ?? 0.0;
                  SearchAddr addr = SearchAddr(placeName: placeName, place: place, lng: lng, lat: lat,pincode: pincode);
                  widget.backtoHome(context,addr);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.bgPrimary, // Set the background color
                ),
                child: const Text("Confirm Location", style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w600, fontSize: 16),)
            )
          ],
        ),
      ),
    );
  }
}
