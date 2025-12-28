import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/model/core/api_endpoints.dart';
import 'package:weather_app/model/failures/main_failure.dart';
import 'package:weather_app/model/weather_model/weather_model.dart';

class ApiService {
  Future<Either<MainFailure, WeatherModel>> getWeather(
      {String? place, Position? usrLocation}) async {
    try {
      final Response response;
      if (place != null) {
        response = await Dio()
            .get(ApiEndpoints.weatherUrl, queryParameters: {'q': place});
      } else {
        response = await Dio().get(ApiEndpoints.weatherLatLongUrl,
            queryParameters: {
              'lat': usrLocation!.latitude,
              'lon': usrLocation.longitude
            });
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = WeatherModel.fromJson(response.data);
        // Cache data
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('last_weather_data', jsonEncode(response.data));
        return Right(result);
      } else {
        return const Left(MainFailure.serverFailure());
      }
    } catch (e) {
      print("API ERROR: $e"); // Added logging
      // Try to load from cache
      try {
        final prefs = await SharedPreferences.getInstance();
        final String? cachedData = prefs.getString('last_weather_data');
        if (cachedData != null) {
          final result = WeatherModel.fromJson(jsonDecode(cachedData));
          return Right(result);
        }
      } catch (_) {}
      return const Left(MainFailure.clientFailure());
    }
  }
}
