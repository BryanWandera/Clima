import 'package:clima/screens/city_screen.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/get_location.dart';

const apiKey = '76305333615a567a106d0fc99789a277';

class LocationWeather {
  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelp moreNetworking = NetworkHelp(
        url:
            'http://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric');
    var cityData = await moreNetworking.getData();
    return cityData;
  }

  Future<dynamic> getLocationWeather() async {
    var weatherData;
    GetLocation theLocation = GetLocation();
    await theLocation.gettingLocation();

    NetworkHelp networking = NetworkHelp(
        url:
            'https://api.openweathermap.org/data/2.5/weather?lat=${theLocation.theLatitude}&lon=${theLocation.theLongitude}&appid=$apiKey&units=metric');
    weatherData = await networking.getData();

    return weatherData;
  }
}
