import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:weather_app/features/device_location/data/repositories/device_location_repository_impl.dart';
import 'package:weather_app/features/device_location/domain/repositories/device_location_repository.dart';
import 'package:weather_app/features/realtime_weather/data/datasources/remote/realtime_weather_api_service.dart';
import 'package:weather_app/features/realtime_weather/data/repositories/realtime_weather_repository_impl.dart';
import 'package:weather_app/features/realtime_weather/domain/repositories/realtime_weather_repository.dart';
import 'package:weather_app/features/realtime_weather/domain/usecases/fetch_realtime_weather.dart';

import 'features/device_location/domain/usecases/determine_position.dart';
import 'features/device_location/presentation/bloc/device_location_bloc.dart';
import 'features/realtime_weather/presentation/bloc/realtime_weather_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<Dio>(Dio());

  //Dependencies
  sl.registerSingleton<RealtimeWeatherApiService>(
      RealtimeWeatherApiService(sl()));
  sl.registerSingleton<RealtimeWeatherRepository>(
      RealtimeWeatherRepositoryImpl(sl()));

  sl.registerSingleton<DeviceLocationRepository>(
      DeviceLocationRepositoryImpl());

  //UseCases

  sl.registerSingleton<FetchRealtimeWeatherUseCase>(
      FetchRealtimeWeatherUseCase(sl()));

  sl.registerSingleton<DeterminePositionUseCase>(
      DeterminePositionUseCase(sl()));

  //Blocs

  sl.registerFactory<RealtimeWeatherBloc>(() => RealtimeWeatherBloc(sl()));
  sl.registerFactory<DevicePositionBloc>(() => DevicePositionBloc(sl(),));
}
