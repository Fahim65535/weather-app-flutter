import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import 'package:weather_app_flutter/core/colors.dart';

import 'package:weather_app_flutter/model/weather_data_current.dart';

class ComfortLevelWidget extends StatelessWidget {
  final WeatherDataCurrent weatherDataCurrent;

  const ComfortLevelWidget({Key? key, required this.weatherDataCurrent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
          child: const Text(
            'Comfort level',
            style: TextStyle(fontSize: 25),
          ),
        ),
        SizedBox(
          height: 220,
          child: Column(
            children: [
              Center(
                child: SleekCircularSlider(
                  min: 0,
                  max: 100,
                  initialValue: weatherDataCurrent.current.humidity!.toDouble(),
                  appearance: CircularSliderAppearance(
                    customWidths: CustomSliderWidths(
                      progressBarWidth: 16,
                      trackWidth: 16,
                      handlerSize: 0,
                    ),
                    infoProperties: InfoProperties(
                        bottomLabelText: 'Humidity',
                        bottomLabelStyle: const TextStyle(
                          letterSpacing: 0.4,
                          fontSize: 21,
                          height: 1.5,
                        )),
                    size: 170,
                    animationEnabled: true,
                    customColors: CustomSliderColors(
                      hideShadow: true,
                      trackColor: CustomColors.thirdGradientColor,
                      progressBarColors: [
                        CustomColors.firstGradientColor,
                        CustomColors.secondGradientColor,
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Feels Like  ${weatherDataCurrent.current.feelsLike}',
                    style: const TextStyle(
                      fontSize: 18,
                      letterSpacing: 0.3,
                      color: CustomColors.textColorBlack,
                    ),
                  ),
                  Text(
                    'UV index  ${weatherDataCurrent.current.uvi}',
                    style: const TextStyle(
                      fontSize: 18,
                      letterSpacing: 0.4,
                      color: CustomColors.textColorBlack,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
