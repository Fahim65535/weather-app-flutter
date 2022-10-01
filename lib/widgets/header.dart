import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:weather_app_flutter/controller/weather_controller.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({super.key});

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  String city = '';

  String date = DateFormat('yMMMMd').format(DateTime.now());
  final WeatherController weatherController = Get.put(
    WeatherController(),
    permanent: true,
  );

  @override
  void initState() {
    getAdress(
      weatherController.getLatitude().value,
      weatherController.getLongitude().value,
    );
    super.initState();
  }

  getAdress(lat, lan) async {
    List<Placemark> placemark = await placemarkFromCoordinates(lat, lan);
    Placemark place = placemark[0];
    setState(() {
      city = place.locality!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 12, right: 12),
          alignment: Alignment.topLeft,
          child: Text(
            city,
            style: const TextStyle(
              fontSize: 40,
              letterSpacing: 0.4,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 12, right: 12, bottom: 15),
          alignment: Alignment.topLeft,
          child: Text(
            date,
            style: TextStyle(
              fontSize: 25,
              letterSpacing: 0.4,
              color: Colors.grey[600],
            ),
          ),
        ),
      ],
    );
  }
}
