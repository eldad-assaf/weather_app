//import 'package:daily_news/features/daily_news/domain/entities/article.dart';
import '../../domain/entities/realtime_weather.dart';

class RealtimeWeatherModel extends RealtimeWeatherEntity {
  const RealtimeWeatherModel({
    super.loactionName,
    super.tempC,
    super.tempF,
    super.isDay,
    super.conditionText,
    super.conditionIcon,
    super.conditionCode,
  });

  factory RealtimeWeatherModel.fromJson(Map<String, dynamic> map) {
    return RealtimeWeatherModel(
      loactionName: map['location']['name'] ?? "",
      tempC: (map['current']['temp_c'] ?? 0.0).toDouble(),
      tempF: (map['current']['temp_f'] ?? 0.0).toDouble(),
      isDay: map['current']['is_day'] ?? 0,
      conditionText: map['current']['condition']['text'] ?? "",
      conditionIcon: map['current']['condition']['icon'] ?? "",
      conditionCode: map['current']['condition']['code'] ?? 0,
    );
  }

  factory RealtimeWeatherModel.fromEntity(RealtimeWeatherEntity entity) {
    return RealtimeWeatherModel(
      loactionName: entity.loactionName,
      tempC: entity.tempC,
      tempF: entity.tempF,
      isDay: entity.isDay,
      conditionText: entity.conditionText,
      conditionIcon: entity.conditionIcon,
      conditionCode: entity.conditionCode,
    );
  }
}
