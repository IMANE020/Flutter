import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather_app/controller/location_controller.dart';
import 'package:weather_app/controller/weather_controller.dart';
import 'package:weather_app/view/core/constants.dart';
import 'package:weather_app/view/home/home_page.dart';

class SearchSuggestions extends StatelessWidget {
  SearchSuggestions({Key? key}) : super(key: key);

  final LocationController _locControl = Get.put(LocationController());
  final WeatherController weatherCtrl = Get.put(WeatherController());

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          highlightColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
          onTap: () async {
            Position position = await _locControl.getLocationData();
            await weatherCtrl.getWeatherData(userLocation: position);
            await Get.offAll(() => HomePage());
          },
          child: GetBuilder<LocationController>(
              init: LocationController(),
              builder: (_locCtrl) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: cardDecoration,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.my_location,
                        color: blueColor,
                        size: 20,
                      ),
                      const SizedBox(width: 10),
                      _locCtrl.isLocationLoading
                          ? const SizedBox(height: 15, width: 15, child: CircularProgressIndicator(strokeWidth: 2))
                          : Text(
                              'Ma position',
                              style: darkTxt14,
                            )
                    ],
                  ),
                );
              }),
        ),

      ],
    );
  }
}
