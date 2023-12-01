import 'package:retrofit/retrofit.dart';
import '../../../../../core/constants/constants.dart';
import 'package:dio/dio.dart';
import '../../models/realtime_weather.dart';
part 'realtime_weather_api_service.g.dart';
//**see Dio instructions on pubdev - needs build runner to generate a file */

@RestApi(baseUrl: weatherAPIBaseURL)
abstract class RealtimeWeatherApiService {
  factory RealtimeWeatherApiService(Dio dio) = _RealtimeWeatherApiService;

  @GET('/current.json')
  Future<HttpResponse<RealtimeWeatherModel>> getRealtimeWeather(
    @Query("key") String? apiKey,
    @Query("q") String? latLng,
  );
}
