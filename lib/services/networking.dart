import 'dart:convert';
import 'package:http/http.dart';

class NetworkHelp {
  String url;

  NetworkHelp({this.url});

  Future getData() async {
    Response response = await get(url);
    var data = response.body;

    if (response.statusCode == 200) {
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}

//String url = 'https://api.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=76305333615a567a106d0fc99789a277';
