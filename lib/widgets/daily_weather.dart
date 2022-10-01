import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:weather_app_flutter/core/colors.dart';
import 'package:weather_app_flutter/model/weather_data_daily.dart';

class DailyWeatherWidget extends StatelessWidget {
  final WeatherDataDaily weatherDataDaily;

  const DailyWeatherWidget({Key? key, required this.weatherDataDaily})
      : super(key: key);

  //string manipulation
  String getDay(final day) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(day * 1000);
    final x = DateFormat('EEE').format(time);
    return x;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      margin: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: CustomColors.dividerLine.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topCenter,
            margin: const EdgeInsets.only(bottom: 5),
            child: const Text(
              'Next days',
              style: TextStyle(
                color: CustomColors.textColorBlack,
                fontSize: 20,
              ),
            ),
          ),
          dailyList(),
        ],
      ),
    );
  }

  Widget dailyList() {
    return SizedBox(
      height: 310,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: weatherDataDaily.daily.length > 7
            ? 7
            : weatherDataDaily.daily.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 60,
                      child: Text(
                        getDay(weatherDataDaily.daily[index].dt),
                        style: const TextStyle(
                          color: CustomColors.textColorBlack,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Image.asset(
                      "assets/weather/${weatherDataDaily.daily[index].weather![0].icon}.png",
                      height: 40,
                      width: 40,
                    ),
                    Text(
                      '${weatherDataDaily.daily[index].temp!.max}° / ${weatherDataDaily.daily[index].temp!.min}°',
                      style: const TextStyle(
                        color: CustomColors.textColorBlack,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 1,
                color: CustomColors.dividerLine.withOpacity(0.6),
              ),
            ],
          );
        },
      ),
    );
  }
}
