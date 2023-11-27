import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:weather_app/features/device_location/data/repositories/device_location_repository_impl.dart';
import 'package:weather_app/features/device_location/domain/repositories/device_location_repository.dart';
import 'package:weather_app/features/device_location/domain/usecases/save_last_position.dart';
import 'package:weather_app/features/map_view/data/repositories/camera_position_repository_impl.dart';
import 'package:weather_app/features/map_view/domain/repositories/camera_poistion_repository.dart';
import 'package:weather_app/features/map_view/domain/usecases/determine_camera_position.dart';
import 'package:weather_app/features/map_view/presentation/bloc/camera_position_bloc.dart';
import 'package:weather_app/features/realtime_weather/data/datasources/remote/realtime_weather_api_service.dart';
import 'package:weather_app/features/realtime_weather/data/repositories/realtime_weather_repository_impl.dart';
import 'package:weather_app/features/realtime_weather/domain/repositories/realtime_weather_repository.dart';
import 'package:weather_app/features/realtime_weather/domain/usecases/fetch_realtime_weather.dart';

import 'features/device_location/domain/usecases/determine_position.dart';
import 'features/device_location/presentation/bloc/device_position_bloc.dart';
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

  sl.registerSingleton<CameraPositionRepository>(
      CameraPositionRepositoryImpl());

  //UseCases

  sl.registerSingleton<FetchRealtimeWeatherUseCase>(
      FetchRealtimeWeatherUseCase(sl()));

  sl.registerSingleton<DeterminePositionUseCase>(
      DeterminePositionUseCase(sl()));

  sl.registerSingleton<SaveLastPositionUseCase>(SaveLastPositionUseCase(sl()));

  sl.registerSingleton<DetermineCameraPositionUseCase>(
      DetermineCameraPositionUseCase(sl()));

  //Blocs

  sl.registerFactory<RealtimeWeatherBloc>(() => RealtimeWeatherBloc(sl()));
  sl.registerFactory<DevicePositionBloc>(() => DevicePositionBloc(
        sl(),
        sl(),
      ));
  sl.registerFactory<CameraPositionBloc>(() => CameraPositionBloc(sl()));
}
