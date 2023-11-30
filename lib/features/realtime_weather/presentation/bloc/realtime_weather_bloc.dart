// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    String? positionToFetchTheWeather;
    emit(const RealtimeWeatherLoading());

    if (event.position == null) {
      //on app start the event is triggerd with a null position (String)
      //checks for last position from sf
      final sf = await SharedPreferences.getInstance();
      final lastPosition = sf.getString('position');
      if (lastPosition != null) {
        positionToFetchTheWeather = lastPosition;
      } else {
        //TODO: change to jerusalem?
        positionToFetchTheWeather = "31.766982, 35.213685"; //  Jerusalem
      }
      //lat: 31.766982, lng: 35.213685)
    } else {
      //event was triggrerd with the users position
      positionToFetchTheWeather = event.position;
    }

    final dataState =
        await _realtimeWeatherUseCase(params: positionToFetchTheWeather);
    if (dataState is DataSucess && dataState.data != null) {
      emit(RealtimeWeatherDone(dataState.data!));
    }
    if (dataState is DataFailed) {
      emit(RealtimeWeatherError(dataState.error!));
    }
  }
}
