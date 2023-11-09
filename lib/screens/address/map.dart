
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:flutter/material.dart';
// import 'package:mapbox_gl/mapbox_gl.dart';

class MapBox extends StatefulWidget {
  const MapBox({super.key});

  @override
  State<MapBox> createState() => _MapBoxState();
}

class _MapBoxState extends State<MapBox> {
  final accessToken = "pk.eyJ1Ijoic2FoaWxjb2RlcjEiLCJhIjoiY2xhejYyOGdvMGlkajN3cnpnZXhvMGN3MSJ9.3kZ0cQL6qD9_JrFW557_0w";

  // MapViewController controller;
  //
  // void _onMapViewCreated(MapViewController controller) {
  //   this.controller = controller;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapWidget(
          resourceOptions: ResourceOptions(accessToken: accessToken),
      )
    );
  }
}
