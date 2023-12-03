part of 'device_position_bloc.dart';

abstract class DevicePositionState extends Equatable {
  final Position? position;
  final Object? error;
  const DevicePositionState({this.position, this.error});

  @override
  List<Object?> get props => [position, error];
}

final class DeviceLocationInitial extends DevicePositionState {}

class DevicePositionLoading extends DevicePositionState {
  const DevicePositionLoading();
}

class DevicePositionDone extends DevicePositionState {
  const DevicePositionDone(Position position) : super(position: position);
}

class DeviceLocationServicesNotEnabled extends DevicePositionState {
  const DeviceLocationServicesNotEnabled(Object error) : super(error: error);
}

class DeviceLocationPermissionsDeniedForever extends DevicePositionState {
  const DeviceLocationPermissionsDeniedForever(Object error)
      : super(error: error);
}

class DeviceLocationPermissionsDenied extends DevicePositionState {
  const DeviceLocationPermissionsDenied(Object error) : super(error: error);
}

class DeviceLocationError extends DevicePositionState {
  const DeviceLocationError(Object error) : super(error: error);
}
