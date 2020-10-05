import 'package:geolocator/geolocator.dart';

class GetLocation {
  double theLatitude;
  double theLongitude;

  Future<void> gettingLocation() async {
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      theLatitude = position.latitude;
      theLongitude = position.longitude;
    } catch (exception) {
      print(exception);
    }
  }
}
