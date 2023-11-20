

import 'package:weather_app/features/realtime_weather/domain/entities/realtime_weather.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/realtime_weather_repository.dart';

class FetchRealtimeWeatherUseCase implements UseCase<DataState<RealtimeWeatherEntity>, String?> {
  final RealtimeWeatherRepository _realtimeWeatherRepository;
  FetchRealtimeWeatherUseCase(this._realtimeWeatherRepository);

  @override
  Future<DataState<RealtimeWeatherEntity>> call({String? params}) {
    return _realtimeWeatherRepository.getRealtimeWeather(params);
  }
}
