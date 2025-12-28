import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:weather_app/model/core/api_endpoints.dart';
import 'package:weather_app/model/weather_model/weather_model.dart';
import 'package:weather_app/view/core/constants.dart';
import 'package:weather_app/view/forecast/forecast_details.dart';
import 'package:weather_app/view/forecast/widgets/forecast_inherited_widget.dart';

class BottomForecastScroll extends StatelessWidget {
  const BottomForecastScroll({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<ListDatas> forecastList =
        ForecastInheritedWidget.of(context)!.forecastList;
    int count = forecastList.length;

    return SizedBox(
      height: 120, // Increased height for pills
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: count,
          itemBuilder: (context, index) {
            String weatherTime = forecastList[index].dtTxt!.substring(
                forecastList[0].dtTxt!.indexOf(' ') + 1,
                forecastList[0].dtTxt!.length);

            final time = weatherTime.substring(0, 5);

            return InkWell(
              onTap: () {
                Get.to(ForecastInheritedWidget(
                    forecastList: forecastList,
                    child: ForecastDetails(index: index)));
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Container(
                  width: 70,
                  decoration: BoxDecoration(
                    color: index == 0 ? blueColor : Colors.white.withOpacity(0.9), // Blue for active, opaque white for others
                    borderRadius: BorderRadius.circular(35),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      )
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(time, style: index == 0 ? darkTxt14.copyWith(color: Colors.white) : darkTxt14),
                      Image.network(
                          '${ApiEndpoints.climateImgUrl}/${forecastList[index].weather![0].icon}@2x.png',
                          height: 35,
                          width: 35),
                      Text('${forecastList[index].main!.temp!.floor()}°',
                          style: index == 0 ? darkTxt18.copyWith(color: Colors.white) : darkTxt18)
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
