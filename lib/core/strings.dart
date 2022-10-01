import 'package:weather_app/api/api_key.dart';

import 'constants.dart';

String apiUrl(var lat, var lon) {
  String url;

  url =
      "$kBaseUrl/onecall?lat=$lat&lon=$lon&appid=$apiKey&units=metric&exclude=minutely";
  return url;
}
