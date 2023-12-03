// ignore_for_file: avoid_print

import 'dart:io';
import 'package:dio/dio.dart';
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
      String position) async {
    try {
      final httpResponse = await _realtimeWeatherApiService.getRealtimeWeather(
          weatherAPIKey, position);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        print('ok');
        print(httpResponse.data.loactionName);
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
