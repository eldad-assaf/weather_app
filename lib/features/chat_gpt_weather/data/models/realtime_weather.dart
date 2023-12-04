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
    super.localTime,
    super.lastUpdated,
    super.windMph,
    super.windKph,
    super.cloud,
    super.uv,
  });

  factory RealtimeWeatherModel.fromJson(Map<String, dynamic> map) {
    return RealtimeWeatherModel(
      loactionName: map['location']['name'] ?? "delete",
      tempC: (map['current']['temp_c'] ?? 0.0).toDouble(),
      tempF: (map['current']['temp_f'] ?? 0.0).toDouble(),
      isDay: map['current']['is_day'] ?? 0,
      conditionText: map['current']['condition']['text'] ?? "",
      conditionIcon: map['current']['condition']['icon'] ?? "",
      conditionCode: map['current']['condition']['code'] ?? 0,
      localTime: map['location']['localtime'] ?? "",
      lastUpdated: map['current']['last_updated'] ?? "",
      windMph: (map['current']['wind_mph'] ?? 0.0).toDouble(),
      windKph: (map['current']['wind_kph'] ?? 0.0).toDouble(),
      cloud: map['current']['cloud'] ?? 0,
      uv: (map['current']['uv'] ?? 0.0).toDouble(),
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
        localTime: entity.localTime,
        lastUpdated: entity.lastUpdated,
        windMph: entity.windMph,
        windKph: entity.windKph,
        cloud: entity.cloud,
        uv: entity.uv);
  }
}
