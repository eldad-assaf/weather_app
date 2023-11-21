part of 'device_location_bloc.dart';

abstract class DeviceLocationState extends Equatable {
  final Position? position;
  final String? cityName;
  final Object? error;
  const DeviceLocationState({this.position, this.cityName, this.error});

  @override
  List<Object?> get props => [position, cityName, error];
}

final class DeviceLocationInitial extends DeviceLocationState {}

class DeviceLocationLoading extends DeviceLocationState {
  const DeviceLocationLoading();
}

class DevicePositionDone extends DeviceLocationState {
  const DevicePositionDone(Position position) : super(position: position);
}

class DeviceCityNameDone extends DeviceLocationState {
  const DeviceCityNameDone(String cityName) : super(cityName: cityName);
}

class DeviceLocationServicesNotEnabled extends DeviceLocationState {
  const DeviceLocationServicesNotEnabled(Object error)
      : super(error: error);
}

class DeviceLocationPermissionsDeniedForever extends DeviceLocationState {
  const DeviceLocationPermissionsDeniedForever(Object error)
      : super(error: error);
}

class DeviceLocationPermissionsDenied extends DeviceLocationState {
  const DeviceLocationPermissionsDenied(Object error) : super(error: error);
}

class DeviceLocationError extends DeviceLocationState {
  const DeviceLocationError(Object error) : super(error: error);
}
// class DeviceLocationError extends DeviceLocationState {
//   const DeviceLocationError(Object error) : super(error: error);
// }

// class DeviceLocationError extends DeviceLocationState {
//   const DeviceLocationError(Object error) : super(error: error);
// }
