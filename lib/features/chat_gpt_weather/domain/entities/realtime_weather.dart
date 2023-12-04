import 'package:equatable/equatable.dart';

class RealtimeWeatherEntity extends Equatable {
  final String? loactionName;
  final double? tempC;
  final double? tempF;
  final int? isDay;
  final String? conditionText;
  final String? conditionIcon;
  final int? conditionCode;
  final String? localTime;
  final String? lastUpdated;
  final double? windMph;
  final double? windKph;
  final int? cloud;
  final double? uv;

  const RealtimeWeatherEntity({
    this.loactionName,
    this.tempC,
    this.tempF,
    this.isDay,
    this.conditionText,
    this.conditionIcon,
    this.conditionCode,
    this.localTime,
    this.lastUpdated,
    this.windMph,
    this.windKph,
    this.cloud,
    this.uv,
  });

  @override
  List<Object?> get props {
    return [
      loactionName,
      tempC,
      tempF,
      isDay,
      conditionText,
      conditionIcon,
      conditionCode,
      localTime,
      lastUpdated,
      windMph,
      windKph,
      cloud,
      uv
    ];
  }
}
