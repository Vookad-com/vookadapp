import 'package:Vookad/models/searchAddr.dart';
import 'package:flutter/material.dart';
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
  MapboxMap? mapboxMap;
  String place = "";
  String placeName = "";
  late Timer _debounce = Timer(const Duration(seconds: 1), () { });

  Future<List<String>> getInfo(double lng,double lat) async {
    final response = await http.get(Uri.parse('https://api.mapbox.com/geocoding/v5/mapbox.places/$lng,$lat.json?access_token=pk.eyJ1Ijoic2FoaWxjb2RlcjEiLCJhIjoiY2xhejYyOGdvMGlkajN3cnpnZXhvMGN3MSJ9.3kZ0cQL6qD9_JrFW557_0w'));
    final Map<String, dynamic> data = json.decode(response.body);
    String name = data["features"][0]["text"] ?? "";
    String place = data["features"][0]["place_name"] ?? "";
    return [name,place];
  }
  _onMapCreated(MapboxMap mapboxMap) async {
    this.mapboxMap = mapboxMap;
    mapboxMap.location.updateSettings(LocationComponentSettings(
      enabled: true,
    ));
    loco = await getLoco();
  }

  _onCameraChangeListener(data) async {
    // print("CameraChangedEventData: begin: ${data.begin}, end: ${data.end}");
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
                  SearchAddr addr = SearchAddr(placeName: placeName, place: place, lng: lng, lat: lat);
                  widget.backtoHome(context,addr);
                },
                child: const Text("Confirm Location", style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w600, fontSize: 16),)
            )
          ],
        ),
      ),
    );
  }
}
