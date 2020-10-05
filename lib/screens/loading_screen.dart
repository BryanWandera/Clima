import 'package:flutter/material.dart';
import 'package:clima/services/get_location_weather.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'location_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
//    switchToLocationScreen();
  }

  void getLocationData() async {
    LocationWeather theLocationWeather = LocationWeather();
    dynamic weatherData;
    weatherData = await theLocationWeather.getLocationWeather();

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LocationScreen(
                  data: weatherData,
                )));
//    });
  }

//  void switchToLocationScreen() {
//
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SpinKitRotatingCircle(
          size: 100.0,
          color: Colors.white,
        ),
      ),
    );
  }
}

//Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>LoadingScreen()));
