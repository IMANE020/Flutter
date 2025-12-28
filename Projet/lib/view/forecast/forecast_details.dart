import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/model/core/api_endpoints.dart';
import 'package:weather_app/model/weather_model/weather_model.dart';
import 'package:weather_app/view/core/constants.dart';
import 'package:weather_app/view/forecast/widgets/forecast_inherited_widget.dart';

class ForecastDetails extends StatelessWidget {
  final int index;
  const ForecastDetails({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final forecastList = ForecastInheritedWidget.of(context)!.forecastList[index];
    final dateStr = forecastList.dtTxt!;
    final DateTime date = DateTime.parse(dateStr);
    final String time = "${date.hour}:${date.minute.toString().padLeft(2, '0')}";

    return Scaffold(
      backgroundColor: lightBgColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: Text(
          'Détails',
          style: darkTxt18,
        ),
        centerTitle: true,
        backgroundColor: lightBgColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: cardDecoration,
              child: Column(
                children: [
                   Text('${date.day}/${date.month} - $time', style: darkTxt16),
                   sbHeight10,
                   Image.network(
                      '${ApiEndpoints.climateImgUrl}/${forecastList.weather![0].icon}@4x.png',
                      height: 80,
                      width: 80
                   ),
                   Text('${forecastList.main!.temp!.floor()}°', style: darkTxt60),
                   Text(forecastList.weather![0].description ?? '', style: greyTxt14),
                   sbHeight30,
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                     children: [
                        _detailItem(Icons.water_drop, '${forecastList.main!.humidity}%'),
                        _detailItem(Icons.air, '${forecastList.wind!.speed} km/h'),
                        _detailItem(Icons.speed, '${forecastList.main!.pressure} mb'),
                     ],
                   )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _detailItem(IconData icon, String value) {
    return Column(
      children: [
        Icon(icon, color: blueColor),
        const SizedBox(height: 5),
        Text(value, style: darkTxt14),
      ],
    );
  }
}
