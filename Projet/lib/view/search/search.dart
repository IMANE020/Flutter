import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/controller/weather_controller.dart';
import 'package:weather_app/view/core/constants.dart';
import 'package:weather_app/view/home/home_page.dart';
import 'package:weather_app/view/search/widgets/loading_widget.dart';
import 'package:weather_app/view/search/widgets/suggestions_widget.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);

  final WeatherController weatherCtrl = Get.put(WeatherController());
  final _searchCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
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
              size: 30,
            )),
        title: Text('Rechercher des lieux', style: darkTxt22),
        centerTitle: true,
        backgroundColor: lightBgColor,
        elevation: 0,
      ),
      body: InkWell(
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
        onTap: () {
          FocusManager.instance.primaryFocus!.unfocus();
        },
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                width: screenSize.width,
                height: 60,
                child: TextFormField(
                  controller: _searchCtrl,
                  onFieldSubmitted: (value) async {
                    await weatherCtrl.getWeatherData(
                        savedPlace: _searchCtrl.text.trim());
                  },
                  style: darkTxt16,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search, color: blueColor),
                      onPressed: () async {
                         await weatherCtrl.getWeatherData(
                            savedPlace: _searchCtrl.text.trim());
                      },
                    ),
                    contentPadding: const EdgeInsets.only(left: 20, top: 15),
                    hintText: 'Rechercher une ville',
                    hintStyle: greyTxt14,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              sbHeight30,
              GetBuilder<WeatherController>(
                  init: WeatherController(),
                  builder: (controller) {
                    if (controller.isLoading) {
                      return const SearchLoadingEffect();
                    } else if (controller.isError) {
                      return Text('Impossible de trouver le lieu.',
                          style: darkTxt18);
                    } else if (_searchCtrl.text.isEmpty) {
                      return SearchSuggestions();
                    } else if (controller.weatherData.city != null) {
                      return InkWell(
                        // highlightColor: Colors.transparent,
                        splashFactory: NoSplash.splashFactory,
                        onTap: () async {
                          await controller.getWeatherData(
                              savedPlace: _searchCtrl.text.trim());
                          await Get.offAll(() => HomePage());
                        },
                        child: Container(
                          width: screenSize.width * 9,
                          height: 80,
                          padding: const EdgeInsets.all(10),
                          decoration: cardDecoration,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                controller.weatherData.city!.name!,
                                style: darkTxt22,
                              ),
                              Text(
                                'Pays : ${controller.weatherData.city!.country!}',
                                style: greyTxt14,
                              )
                            ],
                          ),
                        ),
                      );
                    } else {
                      return const Text('');
                    }
                  }),
            ],
          ),
        )),
      ),
    );
  }
}
