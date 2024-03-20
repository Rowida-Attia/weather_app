import 'dart:developer';

import 'package:weather/model/weather_model.dart';
import 'package:dio/dio.dart';

class weatherService {
  final Dio dio;
  final String baseUrl = 'http://api.weatherapi.com/v1';
  final String apiKey = '086ffdebd1b9478aaae141355232911';
  weatherService(this.dio);
  Future<WeatherModel> getCurrentWeather({required String cityName}) async {
    try {
      Response response = await dio
          .get('$baseUrl/forecast.json?key=$apiKey&q=$cityName&days=1');

      WeatherModel weatherModel = WeatherModel.fromjson(response.data);

      return weatherModel;
    } on DioException catch (e) {
      final String errMassage = e.response?.data['error']['message'] ??
          'oops there was an error, try later ';
      throw Exception(errMassage);
    } catch (e) {
      log(e.toString());
      throw Exception('opps there was an error , try later');
    }
  }
}
