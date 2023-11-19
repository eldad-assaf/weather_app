part of 'device_location_bloc.dart';

abstract class DeviceLocationState extends Equatable {
  final Position? position;
  final Object? error;
  const DeviceLocationState({this.position,this.error});
  
  @override
  List<Object?> get props => [position,error];
}

final class DeviceLocationInitial extends DeviceLocationState {}




class DeviceLocationLoading extends DeviceLocationState {
  const DeviceLocationLoading();
}

class DeviceLocationDone extends DeviceLocationState {
  const DeviceLocationDone(Position position)
      : super(position: position);
}

class DeviceLocationError extends DeviceLocationState {
  const DeviceLocationError(Object error) : super(error: error);
}


