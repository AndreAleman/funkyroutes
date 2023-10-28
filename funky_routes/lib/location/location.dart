import 'package:location/location.dart';


void requestLocationPermission() async {
  // Create a new instance of the Location class
  Location location = new Location();

  // Declare variables to store the status of the location services and permissions
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;

  // Check if the location services are enabled
  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    // If the location services are not enabled, request to enable them
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      // If the user denies the request or the location services cannot be enabled, return from the function
      return;
    }
  }

  // Check if we have permission to access the location services
  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    // If we don't have permission, request permission
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      // If the user denies the permission request or the permission cannot be granted, return from the function
      return;
    }
  }
}
