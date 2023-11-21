part of 'device_location_bloc.dart';

abstract class DevicePoditionState extends Equatable {
  final Position? position;
  final Object? error;
  const DevicePoditionState({this.position, this.error});

  @override
  List<Object?> get props => [position, error];
}

final class DeviceLocationInitial extends DevicePoditionState {}

class DevicePositionLoading extends DevicePoditionState {
  const DevicePositionLoading();
}

class DevicePositionDone extends DevicePoditionState {
  const DevicePositionDone(Position position) : super(position: position);
}

class DeviceLocationServicesNotEnabled extends DevicePoditionState {
  const DeviceLocationServicesNotEnabled(Object error) : super(error: error);
}

class DeviceLocationPermissionsDeniedForever extends DevicePoditionState {
  const DeviceLocationPermissionsDeniedForever(Object error)
      : super(error: error);
}

class DeviceLocationPermissionsDenied extends DevicePoditionState {
  const DeviceLocationPermissionsDenied(Object error) : super(error: error);
}

class DeviceLocationError extends DevicePoditionState {
  const DeviceLocationError(Object error) : super(error: error);
}
