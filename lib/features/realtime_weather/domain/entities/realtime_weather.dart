import 'package:equatable/equatable.dart';

class RealtimeWeatherEntity extends Equatable {
  final String? loactionName;
  final double? tempC;
  final double? tempF;
  final int? isDay;
  final String? conditionText;
  final String? conditionIcon;
  final int? conditionCode;

  const RealtimeWeatherEntity({
    this.loactionName,
    this.tempC,
    this.tempF,
    this.isDay,
    this.conditionText,
    this.conditionIcon,
    this.conditionCode,
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
      conditionCode
    ];
  }
}
