// To parse this JSON data, do
//
//     final currentweatherData = currentweatherDataFromJson(jsonString);

import 'dart:convert';

CurrentweatherData currentweatherDataFromJson(String str) =>
    CurrentweatherData.fromJson(json.decode(str));

class CurrentweatherData {
  List<Weather>? weather;
  Main? main;
  Wind? wind;
  Clouds? clouds;
  int? dt;
  String? name;

  CurrentweatherData({
    this.weather,
    this.main,
    this.wind,
    this.clouds,
    this.dt,
    this.name,
  });

  factory CurrentweatherData.fromJson(Map<String, dynamic> json) =>
      CurrentweatherData(
        weather:
            List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
        main: Main.fromJson(json["main"]),
        wind: Wind.fromJson(json["wind"]),
        clouds: Clouds.fromJson(json["clouds"]),
        dt: json["dt"],
        name: json["name"],
      );
}

class Clouds {
  int? all;

  Clouds({
    this.all,
  });

  factory Clouds.fromJson(Map<String, dynamic> json) => Clouds(
        all: json["all"],
      );

  Map<String, dynamic> toJson() => {
        "all": all,
      };
}

class Main {
  int? temp;
  int? tempMin;
  int? tempMax;
  int? humidity;

  Main({
    this.temp,
    this.tempMin,
    this.tempMax,
    this.humidity,
  });

  factory Main.fromJson(Map<String, dynamic> json) => Main(
        temp: json["temp"].toInt(),
        tempMin: json["temp_min"].toInt(),
        tempMax: json["temp_max"].toInt(),
        humidity: json["humidity"],
      );

  Map<String, dynamic> toJson() => {
        "temp": temp,
        "temp_min": tempMin,
        "temp_max": tempMax,
        "humidity": humidity,
      };
}

class Weather {
  String? main;
  String? icon;

  Weather({
    this.main,
    this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        main: json["main"],
        icon: json["icon"],
      );
}

class Wind {
  double? speed;
  int? deg;

  Wind({
    this.speed,
    this.deg,
  });

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        speed: json["speed"].toDouble(),
        deg: json["deg"],
      );

  Map<String, dynamic> toJson() => {
        "speed": speed,
        "deg": deg,
      };
}
