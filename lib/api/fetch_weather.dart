import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app_flutter/core/strings.dart';

import 'package:weather_app_flutter/model/weather_data.dart';
import 'package:weather_app_flutter/model/weather_data_current.dart';
import 'package:weather_app_flutter/model/weather_data_daily.dart';
import 'package:weather_app_flutter/model/weather_data_hourly.dart';

class FetchWeatherApi {
  WeatherData? weatherData;

  //processing teh data from response -> to Json
  Future<WeatherData> processData(lat, lon) async {
    var response = await http.get(Uri.parse(apiUrl(lat, lon)));
    var jsonString = jsonDecode(response.body);
    weatherData = WeatherData(
      WeatherDataCurrent.fromJson(jsonString),
      WeatherDataHourly.fromJson(jsonString),
      WeatherDataDaily.fromJson(jsonString),
    );

    return weatherData!;
  }
}
