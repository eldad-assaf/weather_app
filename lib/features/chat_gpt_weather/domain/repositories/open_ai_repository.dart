
abstract class OpenAIRepository {
  Future<void> getWeatherExplanationFromChatGpt(
      {required String messageContent});
}
