abstract class RealtimeWeatherEvent {
  final String? position; // keep it a String (Not a Position)

  const RealtimeWeatherEvent({this.position});
}

class FetchRealtimeWeatherEvent extends RealtimeWeatherEvent {
  const FetchRealtimeWeatherEvent(String? position) : super(position: position);
}

class ResetToInitialState extends RealtimeWeatherEvent {
  const ResetToInitialState() : super();
}
