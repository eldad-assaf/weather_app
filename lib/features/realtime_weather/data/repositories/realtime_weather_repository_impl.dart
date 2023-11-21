// ignore_for_file: avoid_print

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/core/resources/data_state.dart';
import 'package:weather_app/features/realtime_weather/domain/entities/realtime_weather.dart';
import '../../../../core/constants/constants.dart';
import '../../domain/repositories/realtime_weather_repository.dart';
import '../datasources/remote/realtime_weather_api_service.dart';

class RealtimeWeatherRepositoryImpl extends RealtimeWeatherRepository {
  final RealtimeWeatherApiService _realtimeWeatherApiService;
  RealtimeWeatherRepositoryImpl(
    this._realtimeWeatherApiService,
  );

  @override
  Future<DataState<RealtimeWeatherEntity>> getRealtimeWeather(
      String? cityName) async {
    try {
      // 37.4219983 ,-122.084
      // final httpResponse = await _realtimeWeatherApiService.getRealtimeWeather(
      //     weatherAPIKey, cityName ?? 'tel-aviv');
      final httpResponse = await _realtimeWeatherApiService.getRealtimeWeather(
          weatherAPIKey, '32.318410, 35.265349');
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSucess(httpResponse.data);
      } else {
        return DataFailed(DioException(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
          requestOptions: httpResponse.response.requestOptions,
        ));
      }
    } on DioException catch (e) {
      print('DioException:');
      print(e.toString());
      print(e.message);
      print(e.error);
      print(e.response!.statusMessage.toString());

      return DataFailed(e);
    }
  }
}
