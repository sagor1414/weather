// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather_app/services/api_services.dart';

class HomeController extends GetxController {
  @override
  Future<void> onInit() async {
    await getUserLocation();
    currentWeatherData = getCurrentWeather(latitude.value, longitude.value);
    hourlyweatherData = gethourlyweather(latitude.value, longitude.value);
    super.onInit();
  }

  var isDark = false.obs;
  dynamic currentWeatherData;
  dynamic hourlyweatherData;
  var latitude = 0.00.obs;
  var longitude = 0.00.obs;
  var isloaded = false.obs;

  changeTheme() {
    isDark.value = !isDark.value;
    Get.changeThemeMode(isDark.value ? ThemeMode.dark : ThemeMode.light);
  }

  getUserLocation() async {
    var isLocationEnabled;
    var userPermition;
    isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationEnabled) {
      return Future.error("Location is not enabled");
    }

    userPermition = await Geolocator.checkPermission();
    if (userPermition == LocationPermission.deniedForever) {
      return Future.error("Permition is denied for ever");
    } else if (userPermition == LocationPermission.denied) {
      userPermition = await Geolocator.requestPermission();
      if (userPermition == LocationPermission.denied) {
        return Future.error("Permition is denied");
      }
    }
    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      latitude.value = value.latitude;
      longitude.value = value.longitude;
      isloaded.value = true;
    });
  }
}
