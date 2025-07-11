
import 'package:geolocator/geolocator.dart';


class LocationHelper {
  // Function to get the current location
  static Future<Position> getLocation() async {
    try {
      Position position = await _determinePosition();
      print('Current Location: ${position.latitude}, ${position.longitude}');
      // Do something with the location data, e.g., update UI or make API calls.
      return position;
    } catch (e) {
      print('Error getting location: $e');
      await Geolocator.checkPermission();
      await Geolocator.requestPermission();
      return Future.error('Location permissions are denied');
      //throw e;
      // Handle errors or show a message to the user.
    }
  }
    
    // Your _determinePosition function here...


  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  static Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the 
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
        return Future.error('Location permissions are denied');
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately. 
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
    } 

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

}



