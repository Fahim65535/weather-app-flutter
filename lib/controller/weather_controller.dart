import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather_app_flutter/api/fetch_weather.dart';
import 'package:weather_app_flutter/model/weather_data.dart';

class WeatherController extends GetxController {
  //create variables
  final RxBool _isLoading = true.obs;
  final RxDouble _latitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;
  final RxInt _currentIndex = 0.obs;

  //getting instances of them
  RxBool checkLoading() => _isLoading;
  RxDouble getLatitude() => _latitude;
  RxDouble getLongitude() => _longitude;
  WeatherData getData() => weatherData.value;

  final weatherData = WeatherData().obs;

  @override
  void onInit() {
    if (_isLoading.isTrue) {
      getLocation();
    } else {
      getIndex();
    }
    super.onInit();
  }

  getLocation() async {
    bool isServiceEnabled;
    LocationPermission locationPermission;

    isServiceEnabled = await Geolocator.isLocationServiceEnabled();

    //return if not enabled
    if (!isServiceEnabled) {
      return Future.error('Location not enabled');
    }

    //status of permission
    locationPermission = await Geolocator.checkPermission();

    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error('Permission denied forever');
    } else if (locationPermission == LocationPermission.denied) {
      //request for permission
      locationPermission = await Geolocator.requestPermission();

      if (locationPermission == LocationPermission.denied) {
        return Future.error('Permission denied');
      }
    }

    //getting currentposition

    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then(
      (value) {
        //update lat and lon
        _latitude.value = value.latitude;
        _longitude.value = value.longitude;
        // print(value.latitude);
        // print(value.longitude);
        //calling api
        return FetchWeatherApi()
            .processData(value.latitude, value.longitude)
            .then(
          (value) {
            weatherData.value = value;
            _isLoading.value = false;
          },
        );
      },
    );
  }

  RxInt getIndex() {
    return _currentIndex;
  }
}
