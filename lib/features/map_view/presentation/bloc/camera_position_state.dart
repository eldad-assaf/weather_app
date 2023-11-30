part of 'camera_position_bloc.dart';

abstract class CameraPositionState extends Equatable {
  final CameraPosition? cameraPosition;
  final Object? error;
   
  const CameraPositionState({this.cameraPosition, this.error});

  @override
  List<Object?> get props => [cameraPosition, error];
}

final class CameraPositionInitial extends CameraPositionState {}

final class CameraPositionLoading extends CameraPositionState {}

class CameraPositionDone extends CameraPositionState {
  const CameraPositionDone(CameraPosition cameraPosition)
      : super(cameraPosition: cameraPosition);
}

class CameraPositionError extends CameraPositionState {
  const CameraPositionError(Object error) : super(error: error);
}
