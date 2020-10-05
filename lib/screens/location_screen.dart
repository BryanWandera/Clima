import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/services/get_location_weather.dart';
import 'package:clima/screens/city_screen.dart';

class LocationScreen extends StatefulWidget {
  dynamic data;
  LocationScreen({this.data});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  dynamic weather;
  dynamic description;
  dynamic city;
  dynamic temperature;
  dynamic temp;
  dynamic weatherIcon;
  dynamic message;
  dynamic cityWeatherData;
  dynamic theCityName;

  WeatherModel getTheWeatherIcon = WeatherModel();

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        message = "Can't return weather data at this time";
        city = '🤥';
        temperature = 0;
        weatherIcon = '🤪';
        return;
      }
      weather = weatherData['weather'][0]['main'];
      description = weatherData['weather'][0]['description'];
      city = 'in ${weatherData['name']}';
      temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      var condition = weatherData['weather'][0]['id'];

      weatherIcon = getTheWeatherIcon.getWeatherIcon(condition);
      message = getTheWeatherIcon.getMessage(temperature);
    });
  }

  @override
  void initState() {
    updateUI(widget.data);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      setState(() {
                        LocationWeather getNewLocationWeather =
                            LocationWeather();
                        var newWeatherData =
                            getNewLocationWeather.getLocationWeather();
                        updateUI(newWeatherData);
                      });
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CityScreen()));

                      if (typedName != null) {
                        LocationWeather getWeather = LocationWeather();
                        var weatherData =
                            await getWeather.getCityWeather(typedName);
                        print(weatherData);
                        updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0, bottom: 20.0, left: 20.0),
                child: Text(
                  '$message $city!',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//var weather = data['weather'][0]['main'];
//var description = data['weather'][0]['description'];
//var city = data['name'];
