// ignore_for_file: avoid_print

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:weather_app/core/resources/data_state.dart';
import 'package:weather_app/features/realtime_weather/domain/entities/realtime_weather.dart';
import '../../domain/repositories/realtime_weather_repository.dart';
import '../datasources/remote/realtime_weather_api_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class RealtimeWeatherRepositoryImpl extends RealtimeWeatherRepository {
  final RealtimeWeatherApiService _realtimeWeatherApiService;
  RealtimeWeatherRepositoryImpl(
    this._realtimeWeatherApiService,
  );

  @override
  Future<DataState<RealtimeWeatherEntity>> getRealtimeWeather(
      String position) async {
    try {
      final x = dotenv.env['WEATHER_API_KEY'];
      final x2 = dotenv.env['CHAT_API_KEY'];

      print('key : $x , $x2');
      final httpResponse = await _realtimeWeatherApiService.getRealtimeWeather(
          dotenv.env['WEATHER_API_KEY'], position);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
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
