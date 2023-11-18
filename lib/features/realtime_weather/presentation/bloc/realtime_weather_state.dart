import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';
import 'package:weather_app/features/realtime_weather/domain/entities/realtime_weather.dart';

abstract class RealtimeWeatherState extends Equatable {
  final RealtimeWeatherEntity? realtimeWeather;
  final DioException? error;

  const RealtimeWeatherState({this.realtimeWeather, this.error});

  @override
  List<Object?> get props => [realtimeWeather, error];
}

class RealtimeWeatherInitial extends RealtimeWeatherState {
  const RealtimeWeatherInitial();
}

class RealtimeWeatherLoading extends RealtimeWeatherState {
  const RealtimeWeatherLoading();
}

class RealtimeWeatherDone extends RealtimeWeatherState {
  const RealtimeWeatherDone(RealtimeWeatherEntity realtimeWeather)
      : super(realtimeWeather: realtimeWeather);
}

class RealtimeWeatherError extends RealtimeWeatherState {
  const RealtimeWeatherError(DioException error) : super(error: error);
}
