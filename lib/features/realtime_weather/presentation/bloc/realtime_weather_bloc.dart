import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/realtime_weather/domain/usecases/fetch_realtime_weather.dart';
import 'package:weather_app/features/realtime_weather/presentation/bloc/realtime_weather_event.dart';
import 'package:weather_app/features/realtime_weather/presentation/bloc/realtime_weather_state.dart';
import '../../../../core/resources/data_state.dart';

class RealtimeWeatherBloc
    extends Bloc<RealtimeWeatherEvent, RealtimeWeatherState> {
  final FetchRealtimeWeatherUseCase _realtimeWeatherUseCase;
  RealtimeWeatherBloc(this._realtimeWeatherUseCase)
      : super(const RealtimeWeatherInitial()) {
    on<FetchRealtimeWeatherEvent>(onFetchRealtimeWeather);
  }

  void onFetchRealtimeWeather(FetchRealtimeWeatherEvent event,
      Emitter<RealtimeWeatherState> emit) async {
    print('onFetchRealtimeWeather');
    final dataState = await _realtimeWeatherUseCase();
    if (dataState is DataSucess && dataState.data != null) {
      print('success');
      emit(RealtimeWeatherDone(dataState.data!));
    }
    if (dataState is DataFailed) {
      print('failed');

      emit(RealtimeWeatherError(dataState.error!));
    }
  }
}