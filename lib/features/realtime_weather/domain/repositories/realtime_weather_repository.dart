import '../../../../core/resources/data_state.dart';
import '../entities/realtime_weather.dart';

abstract class RealtimeWeatherRepository {
  //api methods
  Future<DataState<RealtimeWeatherEntity>> getRealtimeWeather(String? cityName);
}
