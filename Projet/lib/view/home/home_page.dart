import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weather_app/controller/weather_controller.dart';
import 'package:weather_app/model/core/api_endpoints.dart';
import 'package:weather_app/view/core/constants.dart';
import 'package:weather_app/view/forecast/forecast_page.dart';
import 'package:weather_app/view/forecast/widgets/forecast_inherited_widget.dart';
import 'package:weather_app/view/home/widgets/animated_weather_icon.dart';
import 'package:weather_app/view/home/widgets/bottom_forecast.dart';
import 'package:weather_app/view/home/widgets/home_top_illustration.dart';
import 'package:weather_app/view/home/widgets/loading_widget.dart';
import 'package:weather_app/view/home/widgets/wind_humidity.dart';
import 'package:weather_app/view/search/search.dart';
import 'package:weather_app/view/core/ui_helper.dart';
import 'package:google_fonts/google_fonts.dart';


class HomePage extends StatefulWidget {
  final Position? usrLocation;
  final String? place;
  const HomePage({Key? key, this.usrLocation, this.place}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  final WeatherController weatherControl = Get.put(WeatherController());
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 30),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: -100.0, end: 100.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return GetBuilder<WeatherController>(
        init: WeatherController(),
        builder: (weatherCtrl) {
          return AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Stack(
                children: [
                  // Animated background
                  Positioned.fill(
                    child: Transform.translate(
                      offset: Offset(_animation.value, 0),
                      child: Transform.scale(
                        scale: 1.3,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(UiHelper.getDynamicBackground(
                                iconCode: (weatherCtrl.weatherData.list != null && weatherCtrl.weatherData.list!.isNotEmpty)
                                    ? weatherCtrl.weatherData.list![0].weather![0].icon
                                    : null
                              )),
                              fit: BoxFit.cover,
                              filterQuality: FilterQuality.high,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Gradient overlay
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            lightBgColor.withOpacity(0.1),
                            lightBgColor.withOpacity(0.2),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Main content
                  Scaffold(
                    backgroundColor: Colors.transparent,
                    appBar: AppBar(
                      backgroundColor: Colors.transparent,
                              elevation: 0,
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Météo', style: darkTxt22),
                          // Date placeholder - ideally dynamic
                          Text('Aujourd\'hui', style: greyTxt14), 
                        ],
                      ),
                      actions: [
                        Container(
                          margin: const EdgeInsets.only(right: 20, top: 10, bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: IconButton(
                              onPressed: () {
                                Get.to(SearchPage());
                              },
                              icon: const Icon(
                                Icons.search,
                                color: blueColor,
                                size: 24,
                              )),
                        ),
                      ],
                    ),
                    body: RefreshIndicator(
                      onRefresh: () async {
                        return await weatherCtrl.getWeatherData(
                            savedPlace:
                                weatherCtrl.weatherData.city!.name.toString());
                      },
                      child: Padding(
                padding: const EdgeInsets.all(20),
                child: (weatherCtrl.isLoading || weatherCtrl.weatherData.list == null)
                    ? const LoadingEffect()
                    : (weatherCtrl.isError)
                        ? const Center(child: Text('Erreur de chargement'))
                        : Builder(builder: (context) {
                            final weatherDetail = weatherCtrl.weatherData.list![0];
                            final String climateDescription = weatherDetail.weather![0].description.toString();
                             // Capitalize first letter
                            final String desc = climateDescription.isNotEmpty 
                                ? '${climateDescription[0].toUpperCase()}${climateDescription.substring(1)}'
                                : '';
                            
                            return ListView(
                              children: [
                                // 1. Current Weather Card
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: cardDecoration,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                               const Icon(Icons.location_on_outlined, size: 16, color: secondaryText),
                                               sbWidth10,
                                               Text(
                                                weatherCtrl.weatherData.city!.name.toString(),
                                                style: darkTxt16.copyWith(color: secondaryText),
                                              ),
                                            ],
                                          ),
                                          sbHeight10,
                                          Text(
                                            '${weatherDetail.main!.temp!.floor()}°',
                                            style: const TextStyle(
                                              fontFamily: 'Freezing',
                                              fontSize: 60,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            desc,
                                            style: darkTxt16,
                                          ),
                                        ],
                                      ),

                                      // Weather Icon
                                      AnimatedWeatherIcon(
                                        iconUrl: '${ApiEndpoints.climateImgUrl}/${weatherDetail.weather![0].icon}@4x.png',
                                        conditionCode: weatherDetail.weather![0].icon ?? '01d',
                                      ),
                                    ],
                                  ),
                                ),
                                sbHeight20,

                                // 2. Hourly Forecast
                                Text('Prévisions horaires', style: darkTxt16),
                                sbHeight10,
                                ForecastInheritedWidget(
                                  forecastList: weatherCtrl.weatherData.list!,
                                  child: const BottomForecastScroll() // We need to update this widget style
                                ),
                                sbHeight20,

                                // 3. Details Grid
                                WindAndHumidityContainer(
                                  humidity: weatherDetail.main!.humidity.toString(),
                                  windSpeed: ((weatherDetail.wind!.speed ?? 0) * 3.6).round().toString(),
                                  // Pass visibility and pressure if possible, or mocked
                                  visibility: (weatherCtrl.weatherData.list![0].visibility != null) 
                                      ? (weatherCtrl.weatherData.list![0].visibility! / 1000).toStringAsFixed(0) 
                                      : '10', // Default mock
                                  pressure: (weatherDetail.main!.pressure != null) 
                                      ? weatherDetail.main!.pressure.toString()
                                      : '1013',
                                ),
                                sbHeight20,


                                // 4. 7-Day Forecast Link/Section
                                Text('Prévisions sur 5 jours', style: darkTxt16),
                                sbHeight10,
                                // We can embed the content of ForecastPage here or keep it as a separate page, 
                                // but the user wants "this design". The design shows a vertical list.
                                // Let's embed a simplified list here.
                                Container(
                                  decoration: cardDecoration,
                                  child: Column(
                                    children: _buildDailyForecast(weatherCtrl.weatherData.list!),
                                  ),
                                ),
                                sbHeight20,
                              ],
                            );
                          }),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        });
  }

  List<Widget> _buildDailyForecast(List<dynamic> forecastList) {
    Map<String, List<dynamic>> dailyGroups = {};
    
    for (var item in forecastList) {
      String dateStr = item.dtTxt!;
      String dayKey = dateStr.substring(0, 10); // YYYY-MM-DD
      if (!dailyGroups.containsKey(dayKey)) {
        dailyGroups[dayKey] = [];
      }
      dailyGroups[dayKey]!.add(item);
    }

    // Take all available days (API usually gives 5, but we show all we have)
    List<String> sortedKeys = dailyGroups.keys.toList()..sort();
    
    return List.generate(sortedKeys.length, (index) {
       String dateKey = sortedKeys[index];
       List<dynamic> items = dailyGroups[dateKey]!;
       
        DateTime date = DateTime.parse(dateKey);
        List<String> days = [
          'Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi', 'Dimanche'
        ];
        String dayName = days[date.weekday - 1];
        if (index == 0) dayName = "Aujourd'hui";

        // Calculate Min/Max for the day
        double minTemp = 1000;
        double maxTemp = -1000;
        // Use middle of the day icon
        var weatherItem = items[items.length ~/ 2]; 

        for (var i in items) {
           if (i.main!.tempMin! < minTemp) minTemp = i.main!.tempMin!;
           if (i.main!.tempMax! > maxTemp) maxTemp = i.main!.tempMax!;
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 80, child: Text(dayName, style: darkTxt14)),
                  Image.network(
                     '${ApiEndpoints.climateImgUrl}/${weatherItem.weather![0].icon}@2x.png',
                     width: 30, height: 30
                  ),
                  Row(
                    children: [
                       Text('${maxTemp.floor()}°', style: darkTxt14),
                       sbWidth10,
                       Text('${minTemp.floor()}°', style: greyTxt14),
                    ],
                  )
                ],
              ),
            ),
             if (index < sortedKeys.length - 1)
               const Divider(height: 1, color: Colors.black12),
          ],
        );
    });
  }
}


