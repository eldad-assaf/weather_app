import 'package:weather_app/core/resources/data_state.dart';

import 'package:weather_app/features/realtime_weather/domain/entities/realtime_weather.dart';

import '../../domain/repositories/realtime_weather_repository.dart';

class RealtimeWeatherRepositoryImpl extends RealtimeWeatherRepository{

  
  @override
  Future<DataState<RealtimeWeatherEntity>> getRealtimeWeather() {
    throw UnimplementedError();
  }

}