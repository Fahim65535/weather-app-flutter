import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:weather_app_flutter/controller/weather_controller.dart';
import 'package:weather_app_flutter/core/colors.dart';
import 'package:weather_app_flutter/widgets/comfort_level.dart';
import 'package:weather_app_flutter/widgets/current_weather.dart';
import 'package:weather_app_flutter/widgets/daily_weather.dart';
import 'package:weather_app_flutter/widgets/header.dart';
import 'package:weather_app_flutter/widgets/hourly_weather.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //call
  final WeatherController weatherController = Get.put(
    WeatherController(),
    permanent: true,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Obx(
          () => weatherController.checkLoading().isTrue
              ? Center(
                  child: SpinKitWave(
                    color: Colors.grey[800],
                    size: 60,
                    duration: const Duration(milliseconds: 1400),
                    itemCount: 6,
                    type: SpinKitWaveType.center,
                  ),
                )
              : ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: [
                    const HeaderWidget(),
                    //for current temp ('current)
                    CurrentWeatherWidget(
                      weatherDataCurrent:
                          weatherController.getData().getCurrentWeather(),
                    ),
                    const SizedBox(height: 20),
                    //for hourly temp
                    HourlyWeatherWidget(
                      weatherDataHourly:
                          weatherController.getData().getHourlyWeather(),
                    ),
                    const SizedBox(height: 15),
                    DailyWeatherWidget(
                      weatherDataDaily:
                          weatherController.getData().getDailyWeather(),
                    ),
                    Container(
                      margin: const EdgeInsets.all(15),
                      height: 1,
                      color: CustomColors.dividerLine.withOpacity(0.5),
                    ),
                    const SizedBox(height: 15),
                    ComfortLevelWidget(
                      weatherDataCurrent:
                          weatherController.getData().getCurrentWeather(),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
