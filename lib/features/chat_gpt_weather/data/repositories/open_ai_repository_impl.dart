import 'package:weather_app/features/chat_gpt_weather/domain/repositories/open_ai_repository.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:weather_app/features/realtime_weather/domain/entities/realtime_weather.dart';

class OpenAIRepositoryImpl extends OpenAIRepository {
  final OpenAI _openAI;

  OpenAIRepositoryImpl(this._openAI);

  @override
  Future<void> getWeatherExplanationFromChatGpt(
      {required RealtimeWeatherEntity realtimeWeatherEntity}) async {
    try {
      //build String 'content' from realtimeWeatherEntity
      print('realeldad');
      final request = ChatCompleteText(messages: [
        Messages(role: Role.user, content: 'say a fact of science in 10 words'),
      ], maxToken: 200, model: ChatModelFromValue(model: 'gpt-3.5-turbo-1106'));
      final ChatCTResponse? response =
          await _openAI.onChatCompletion(request: request);
      print(response!.created.toString());
      for (var element in response.choices) {
        print("data -> ${element.message?.content}");
      }
    } catch (e) {
      print('getWeatherExplanationFromChatGpt error :  ${e.toString()}');
    }
  }
}
