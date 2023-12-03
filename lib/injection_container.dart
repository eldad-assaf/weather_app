import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:weather_app/features/chat_gpt_weather/data/repositories/open_ai_repository_impl.dart';
import 'package:weather_app/features/chat_gpt_weather/domain/repositories/open_ai_repository.dart';
import 'package:weather_app/features/device_position/data/repositories/device_location_repository_impl.dart';
import 'package:weather_app/features/device_position/domain/repositories/device_location_repository.dart';
import 'package:weather_app/features/device_position/domain/usecases/determine_position.dart';
import 'package:weather_app/features/device_position/presentation/bloc/device_position_bloc.dart';
import 'package:weather_app/features/map_view/data/repositories/camera_position_repository_impl.dart';
import 'package:weather_app/features/map_view/domain/repositories/camera_poistion_repository.dart';
import 'package:weather_app/features/map_view/domain/usecases/determine_camera_position.dart';
import 'package:weather_app/features/map_view/domain/usecases/determine_initial_camera_position.dart';
import 'package:weather_app/features/map_view/presentation/bloc/camera_position_bloc.dart';
import 'package:weather_app/features/realtime_weather/data/datasources/remote/realtime_weather_api_service.dart';
import 'package:weather_app/features/realtime_weather/data/repositories/realtime_weather_repository_impl.dart';
import 'package:weather_app/features/realtime_weather/domain/repositories/realtime_weather_repository.dart';
import 'package:weather_app/features/realtime_weather/domain/usecases/fetch_realtime_weather.dart';

import 'features/realtime_weather/presentation/bloc/realtime_weather_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<Dio>(Dio());

  //Dependencies
  sl.registerSingleton<RealtimeWeatherApiService>(
      RealtimeWeatherApiService(sl()));
  sl.registerSingleton<RealtimeWeatherRepository>(
      RealtimeWeatherRepositoryImpl(sl()));

  sl.registerSingleton<DevicePositionRepository>(
      DevicePositionRepositoryImpl());

  sl.registerSingleton<CameraPositionRepository>(
      CameraPositionRepositoryImpl());

    sl.registerSingleton<OpenAI>(OpenAI.instance.build(
    token: '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',
    baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 5)),
    enableLog: true,
  ));

  sl.registerSingleton<OpenAIRepository>(OpenAIRepositoryImpl(sl()));


  //UseCases

  sl.registerSingleton<FetchRealtimeWeatherUseCase>(
      FetchRealtimeWeatherUseCase(sl()));

  sl.registerSingleton<DeterminePositionUseCase>(
      DeterminePositionUseCase(sl()));

  sl.registerSingleton<DetermineInitialCameraPositionUseCase>(
      DetermineInitialCameraPositionUseCase(sl()));

  sl.registerSingleton<DetermineCameraPositionUseCase>(
      DetermineCameraPositionUseCase(sl()));

  //Blocs

  sl.registerFactory<RealtimeWeatherBloc>(() => RealtimeWeatherBloc(sl()));
  sl.registerFactory<DevicePositionBloc>(() => DevicePositionBloc(
        sl(),
      ));
  sl.registerFactory<CameraPositionBloc>(() => CameraPositionBloc(sl(), sl()));
}
