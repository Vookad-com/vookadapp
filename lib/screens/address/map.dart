
import 'package:Vookad/components/mapinput.dart';
import 'package:Vookad/models/searchAddr.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

class MapBox extends StatefulWidget {
  final double lng;
  final double lat;
  const MapBox({super.key,required this.lng,required this.lat});

  @override
  State<MapBox> createState() => _MapBoxState();
}

class _MapBoxState extends State<MapBox> {
  void backtoHome(BuildContext context, SearchAddr address) async {
    var box = Hive.box<SearchAddr>('searchAddrBox');
    await box.put('current', address);
    context.go("/home");
  }

  @override
  Widget build(BuildContext context) {
    return MapInput(lng: widget.lng, lat: widget.lat, backtoHome: backtoHome,);
  }
}
