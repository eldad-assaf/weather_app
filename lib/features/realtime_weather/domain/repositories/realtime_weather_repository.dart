import '../../../../core/resources/data_state.dart';
import '../entities/realtime_weather.dart';

abstract class RealtimeWeatherRepository {
  Future<DataState<RealtimeWeatherEntity>> getRealtimeWeather(String position);
}
