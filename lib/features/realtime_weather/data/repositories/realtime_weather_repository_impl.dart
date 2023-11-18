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
  Future<DataState<RealtimeWeatherEntity>> getRealtimeWeather() async {
    try {
      final httpResponse = await _realtimeWeatherApiService.getRealtimeWeather(
          weatherAPIKey, 'Tel-Aviv');

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSucess(httpResponse.data);
      } else {
        return DataFailed(DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions));
      }
    } on DioException catch (e) {
      print(e.toString());
      return DataFailed(e);
    }
  }
}
