// ignore_for_file: avoid_print

import 'package:weather_app/features/chat_gpt_weather/domain/repositories/open_ai_repository.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:weather_app/features/realtime_weather/domain/entities/realtime_weather.dart';

class OpenAIRepositoryImpl extends OpenAIRepository {
  final OpenAI _openAI;

  OpenAIRepositoryImpl(this._openAI);

  @override
  Future<String?> getWeatherExplanationFromChatGpt(
      {required String messageContent}) async {
    try {
      final request = ChatCompleteText(messages: [
        Messages(role: Role.user, content: messageContent),
      ], maxToken: 200, model: ChatModelFromValue(model: 'gpt-3.5-turbo-1106'));
      final ChatCTResponse? response =
          await _openAI.onChatCompletion(request: request);
      for (var element in response!.choices) {
        print("AI Suggests :  -> ${element.message?.content}");
        return element.message?.content;
      }
    } catch (e) {
      print('getWeatherExplanationFromChatGpt error :  ${e.toString()}');
      rethrow;
    }
    return null;
  }

  @override
  String buildQuestionForChatGpt(
      {required RealtimeWeatherEntity realtimeWeatherEntity}) {
    String basic =
        'write a short text about the weather, suggest what to wear and tell the user if this is the typical weather of the place.';
    String theWeather =
        'the location name is ${realtimeWeatherEntity.loactionName} , the temp in celcius is ${realtimeWeatherEntity.tempC} , the condition text is ${realtimeWeatherEntity.conditionText} ,wind in kph is ${realtimeWeatherEntity.windKph} , clouds is ${realtimeWeatherEntity.cloud.toString()} and uv is ${realtimeWeatherEntity.uv.toString()}      ';
    return basic + theWeather;
  }
}


