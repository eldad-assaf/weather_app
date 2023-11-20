abstract class RealtimeWeatherEvent {
  final String? cityName;

  const RealtimeWeatherEvent({this.cityName});
}

class FetchRealtimeWeatherEvent extends RealtimeWeatherEvent {
  const FetchRealtimeWeatherEvent(String? cityName):super(cityName: cityName);
}
