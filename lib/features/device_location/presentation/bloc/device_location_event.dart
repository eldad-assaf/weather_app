part of 'device_location_bloc.dart';

abstract class DeviceLocationEvent extends Equatable {
  const DeviceLocationEvent();

  @override
  List<Object> get props => [];
}

class DeterminePositionEvent extends DeviceLocationEvent {
  const DeterminePositionEvent();
}

class GeocodeCityNameEvent extends DeviceLocationEvent {
  const GeocodeCityNameEvent();
}
