import 'package:flutter/material.dart';
import 'package:weather_app/model/core/api_endpoints.dart';
import 'package:weather_app/model/weather_model/weather_model.dart';
import 'package:weather_app/view/core/constants.dart';
import 'package:weather_app/view/forecast/widgets/forecast_inherited_widget.dart';

class ForecastWidget extends StatelessWidget {
  final String? weatherDate;
  final List<ListDatas>? dailyForecastList;
  final int index;

  const ForecastWidget({
    Key? key,
    required this.index,
    this.weatherDate,
    this.dailyForecastList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ListDatas forecastList;
    if (dailyForecastList != null) {
      forecastList = dailyForecastList![index];
    } else {
      forecastList = ForecastInheritedWidget.of(context)!.forecastList[index];
    }

    // Calcul approximatif Min/Max pour l'effet visuel (car l'API current forecast donne des points fixes)
    // On simule une plage de température pour l'esthétique
    double temp = forecastList.main!.temp!;
    double tempMin = forecastList.main!.tempMin ?? temp - 2;
    double tempMax = forecastList.main!.tempMax ?? temp + 2;

    if (tempMin == tempMax) {
       tempMin = temp - 3;
       tempMax = temp + 3;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        // decoration: glassDecoration, // On enlève le glass individuel si on est dans une liste
        color: Colors.transparent, 
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Jour
            SizedBox(
              width: 50,
              child: Text(
                weatherDate ?? 'J',
                style: darkTxt18,
              ),
            ),
            
             // Icône
            SizedBox(
              width: 30,
              child: Image.network(
                  '${ApiEndpoints.climateImgUrl}/${forecastList.weather![0].icon}@2x.png',
                  width: 30,
                  height: 30),
            ),

            // Temp Min
            Text('${tempMin.floor()}°', style: greyTxt14.copyWith(fontSize: 18)),

            // Barre de progression (Gradient Bar)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.black12, // Fond track
                  ),
                  child: Stack(
                    children: [
                      FractionallySizedBox(
                        widthFactor: 0.6, // Simule la plage
                        alignment: Alignment.center,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            gradient: const LinearGradient(
                              colors: [Colors.lightBlueAccent, Colors.yellow],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Temp Max
            Text('${tempMax.floor()}°', style: darkTxt18),
          ],
        ),
      ),
    );
  }
}
