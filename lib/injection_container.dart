

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:weather_app/features/realtime_weather/data/datasources/remote/realtime_weather_api_service.dart';

final sl = GetIt.instance;


Future<void> initializeDependencies() async {


  sl.registerSingleton<Dio>(Dio());

  //Dependencies
  sl.registerSingleton<RealtimeWeatherApiService>(RealtimeWeatherApiService(sl()));


  //UseCases

 // sl.registerSingleton<GetArticleUseCase>(GetArticleUseCase(sl()));


  //Blocs

 // sl.registerFactory<LocalArticleBloc>(() => LocalArticleBloc(sl(),sl(),sl()));
}
