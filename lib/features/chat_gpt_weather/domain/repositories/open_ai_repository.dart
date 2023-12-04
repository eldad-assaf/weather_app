import 'package:weather_app/features/realtime_weather/domain/entities/realtime_weather.dart';

abstract class OpenAIRepository {
  Future<void> getWeatherExplanationFromChatGpt(
      {required String messageContent});

  String buildQuestionForChatGpt(
      {required RealtimeWeatherEntity realtimeWeatherEntity});
}
