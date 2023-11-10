import 'package:location/location.dart';

Future<List<double>> getLoco() async {
  Location location = Location();

  bool serviceEnabled;
  PermissionStatus permissionGranted;
  LocationData locationData;

  serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      return Future.value([20.4, 85.7]);
    }
  }

  permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      return Future.value([20.4, 85.7]);
    }
  }

  // Ensure that you return a valid value in the default case
  locationData = await location.getLocation();
  // return Future.value([20.251583, 85.7679309]);
  return Future.value([locationData.latitude ?? 20.251583, locationData.longitude ?? 85.7679309]);
}
