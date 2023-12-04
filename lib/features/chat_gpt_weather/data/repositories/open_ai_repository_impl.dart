import 'package:weather_app/features/chat_gpt_weather/domain/repositories/open_ai_repository.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:weather_app/features/realtime_weather/domain/entities/realtime_weather.dart';

class OpenAIRepositoryImpl extends OpenAIRepository {
  final OpenAI _openAI;

  OpenAIRepositoryImpl(this._openAI);

  @override
  Future<void> getWeatherExplanationFromChatGpt(
      {required String messageContent}) async {
    try {
      final request = ChatCompleteText(messages: [
        Messages(role: Role.user, content: 'say 30 names for boys'),
      ], maxToken: 200, model: ChatModelFromValue(model: 'gpt-3.5-turbo-1106'));
      final ChatCTResponse? response =
          await _openAI.onChatCompletion(request: request);
      for (var element in response!.choices) {
        print("data -> ${element.message?.content}");
      }
    } catch (e) {
      print('getWeatherExplanationFromChatGpt error :  ${e.toString()}');
    }
  }

  @override
  String buildQuestionForChatGpt(
      {required RealtimeWeatherEntity realtimeWeatherEntity}) {
    print('buildQuestionForChatGpt');
    return 'eldad';
  }
}
