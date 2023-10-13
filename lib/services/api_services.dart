// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'package:weather_app/consts/strings.dart';
import 'package:weather_app/models/currentweather_moder.dart';
import 'package:weather_app/models/hourly_weather_model.dart';

getCurrentWeather(lat, long) async {
  var link =
      "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$apiKey&units=metric";
  var res = await http.get(Uri.parse(link));
  if (res.statusCode == 200) {
    var data = currentweatherDataFromJson(res.body.toString());
    return data;
  }
}

gethourlyweather(lat, long) async {
  var link =
      "https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$long&appid=$apiKey&units=metric";
  var res = await http.get(Uri.parse(link));
  if (res.statusCode == 200) {
    var data = hourlyweatherDataFromJson(res.body.toString());
    print("data is recevied");
    return data;
  }
}
