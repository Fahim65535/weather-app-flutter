import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:weather_app_flutter/controller/weather_controller.dart';
import 'package:weather_app_flutter/core/colors.dart';
import 'package:weather_app_flutter/model/weather_data_hourly.dart';

class HourlyWeatherWidget extends StatelessWidget {
  final WeatherDataHourly weatherDataHourly;

  HourlyWeatherWidget({Key? key, required this.weatherDataHourly})
      : super(key: key);

  //card index
  RxInt cardIndex = WeatherController().getIndex();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          alignment: Alignment.topCenter,
          child: const Text(
            "Today",
            style: TextStyle(fontSize: 22),
          ),
        ),
        hourlyList(),
      ],
    );
  }

  Widget hourlyList() {
    return Container(
      height: 169,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: weatherDataHourly.hourly.length > 14
            ? 14
            : weatherDataHourly.hourly.length,
        itemBuilder: (context, index) {
          return Obx(
            () => GestureDetector(
              onTap: () {
                cardIndex.value = index;
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Container(
                  width: 95,
                  margin: const EdgeInsets.only(left: 15, right: 6, bottom: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(10, 8),
                        blurRadius: 6,
                        spreadRadius: 1,
                        color: CustomColors.dividerLine.withOpacity(0.7),
                      ),
                      const BoxShadow(
                        offset: Offset(-10, 9),
                        blurRadius: 6,
                        spreadRadius: 1,
                        color: Colors.white24,
                      ),
                    ],
                    gradient: cardIndex.value == index
                        ? const LinearGradient(
                            colors: [
                              CustomColors.firstGradientColor,
                              CustomColors.secondGradientColor,
                            ],
                          )
                        : const LinearGradient(
                            colors: [
                              CustomColors.thirdGradientColor,
                              CustomColors.fourthGradientColor,
                            ],
                          ),
                  ),
                  child: HourlyDetails(
                    index: index,
                    cardIndex: cardIndex.toInt(),
                    temp: weatherDataHourly.hourly[index].temp!,
                    timestamp: weatherDataHourly.hourly[index].dt!,
                    weatherIcon:
                        weatherDataHourly.hourly[index].weather![0].icon!,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

//hourly details
class HourlyDetails extends StatelessWidget {
  final int temp;
  final int index;
  final int cardIndex;
  final int timestamp;
  final String weatherIcon;

  const HourlyDetails({
    Key? key,
    required this.temp,
    required this.index,
    required this.cardIndex,
    required this.timestamp,
    required this.weatherIcon,
  }) : super(key: key);

  String getTime(final timestamp) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    String x = DateFormat('jm').format(time);
    return x;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Text(
            getTime(timestamp),
            style: TextStyle(
              fontSize: 18,
              color: cardIndex == index
                  ? Colors.white
                  : CustomColors.textColorBlack,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(5),
          child: Image.asset(
            "assets/weather/$weatherIcon.png",
            height: 40,
            width: 40,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Text(
            "$temp°",
            style: TextStyle(
              fontSize: 18,
              color: cardIndex == index
                  ? Colors.white
                  : CustomColors.textColorBlack,
            ),
          ),
        )
      ],
    );
  }
}
