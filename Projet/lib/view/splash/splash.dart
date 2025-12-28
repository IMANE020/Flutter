import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather_app/controller/location_controller.dart';
import 'package:weather_app/controller/weather_controller.dart';
import 'package:weather_app/view/core/constants.dart';
import 'package:weather_app/view/core/ui_helper.dart';
import 'package:weather_app/view/home/home_page.dart';
import 'package:weather_app/view/search/search.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
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
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Stack(
          children: [
            // Animated background layer
            Positioned.fill(
              child: Transform.translate(
                offset: Offset(_animation.value, 0),
                child: Transform.scale(
                  scale: 1.3, // Scale up to allow panning without showing edges
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(UiHelper.getDynamicBackground()),
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
                      Colors.black.withOpacity(0.3),
                      Colors.black.withOpacity(0.1),
                    ],
                  ),
                ),
              ),
            ),
            // Content
            Scaffold(
              backgroundColor: Colors.transparent,
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // App Title
                        Text(
                          'Météo',
                          style: GoogleFonts.outfit(
                            fontSize: 56,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                blurRadius: 10.0,
                                color: Colors.black.withOpacity(0.5),
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                        sbHeight10,
                        Text(
                          'Bienvenue',
                          style: GoogleFonts.outfit(
                            fontSize: 18,
                            color: Colors.white.withOpacity(0.9),
                            shadows: [
                              Shadow(
                                blurRadius: 8.0,
                                color: Colors.black.withOpacity(0.5),
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 80),

                        // Detect Position Card
                        GetBuilder<LocationController>(
                          init: LocationController(),
                          builder: (_locCtrl) {
                            return InkWell(
                              onTap: _locCtrl.isLocationLoading
                                  ? null
                                  : () async {
                                      Position usrLocation =
                                          await _locCtrl.getLocationData();
                                      await weatherControl.getWeatherData(
                                          userLocation: usrLocation);
                                      await Get.offAll(() => const HomePage());
                                    },
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.95),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 20,
                                      offset: const Offset(0, 5),
                                    )
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (_locCtrl.isLocationLoading)
                                      const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: blueColor,
                                        ),
                                      )
                                    else
                                      const Icon(
                                        Icons.my_location,
                                        color: blueColor,
                                        size: 24,
                                      ),
                                    const SizedBox(width: 15),
                                    Text(
                                      'Détecter ma position',
                                      style: darkTxt18.copyWith(color: blueColor),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        sbHeight20,

                        // Manual Selection Card
                        InkWell(
                          onTap: () {
                            Get.to(() => SearchPage());
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.95),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 20,
                                  offset: const Offset(0, 5),
                                )
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.search,
                                  color: secondaryText,
                                  size: 24,
                                ),
                                const SizedBox(width: 15),
                                Text(
                                  'Sélectionner manuellement',
                                  style: darkTxt18.copyWith(color: secondaryText),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }



}
