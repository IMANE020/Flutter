import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:weather_app/model/weather_model/weather_model.dart';
import 'package:weather_app/view/core/constants.dart';
import 'package:weather_app/view/forecast/widgets/forecast_inherited_widget.dart';
import 'package:weather_app/view/forecast/widgets/forecast_widget.dart';


class ForecastPage extends StatelessWidget {
  // final List<ListDatas> forecastList;
  const ForecastPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<ListDatas> forecastList =
        ForecastInheritedWidget.of(context)!.forecastList;
    List<ListDatas> dailyForecastList = [];

    int index = 0;
    String _checkDate = forecastList[index]
        .dtTxt!
        .substring(0, forecastList[0].dtTxt!.indexOf(' ') + 1);
    while (index < forecastList.length) {
      if (forecastList[index]
                  .dtTxt!
                  .substring(0, forecastList[0].dtTxt!.indexOf(' ') + 1) !=
              _checkDate ||
          index == 0) {
        dailyForecastList.add(forecastList[index]);
      }
      _checkDate = forecastList[index]
          .dtTxt!
          .substring(0, forecastList[0].dtTxt!.indexOf(' ') + 1);
      index = index + 1;
    }
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
          'Prévisions 7 jours',
          style: darkTxt18,
        ),
        centerTitle: true,
        backgroundColor: lightBgColor,
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        decoration: cardDecoration,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: dailyForecastList.length,
                  itemBuilder: (context, index) {
                    String dateStr = dailyForecastList[index].dtTxt!;
                    DateTime date = DateTime.parse(dateStr);
                    List<String> days = [
                      'Lundi',
                      'Mardi',
                      'Mercredi',
                      'Jeudi',
                      'Vendredi',
                      'Samedi',
                      'Dimanche'
                    ];
                    String weatherDate = days[date.weekday - 1];

                    if (index == 0) {
                      weatherDate = "Aujourd'hui";
                    }

                    return Column(
                      children: [
                        ForecastWidget(
                          index: index,
                          weatherDate: weatherDate,
                          dailyForecastList: dailyForecastList,
                        ),
                        if (index < dailyForecastList.length - 1)
                          const Divider(color: Colors.black12, height: 1),
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
