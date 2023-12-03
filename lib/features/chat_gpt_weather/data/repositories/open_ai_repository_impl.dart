import 'package:weather_app/features/chat_gpt_weather/domain/repositories/open_ai_repository.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';

class OpenAIRepositoryImpl extends OpenAIRepository {
  final OpenAI _openAI;

  OpenAIRepositoryImpl(this._openAI);

  @override
  Future<void> chatComplete() async {
    final request = ChatCompleteText(messages: [
      Messages(role: Role.user, content: 'say a fact of science in 10 words'),
      // Map.of({"role": "user", "content": 'Hello!'})
    ], maxToken: 200, model: ChatModelFromValue(model: 'gpt-3.5-turbo-1106'));
    //TODO: test it as it is then try moving this instance build to a service class like with 'RealtimeWeatherRepositoryImpl'
    // final openAI = OpenAI.instance.build(
    //   token: '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',
    //   baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 5)),
    //   enableLog: true,
    //);
    final response = await _openAI.onChatCompletion(request: request);
    for (var element in response!.choices) {
      print("data -> ${element.message?.content}");
    }
  }
}
