part of 'device_location_bloc.dart';

abstract class DevicePositionEvent extends Equatable {
  const DevicePositionEvent();

  @override
  List<Object> get props => [];
}

class DeterminePositionEvent extends DevicePositionEvent {
  const DeterminePositionEvent();
}


