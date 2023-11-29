part of 'camera_position_bloc.dart';

abstract class CameraPositionEvent extends Equatable {
  final Position? position;
  const CameraPositionEvent({this.position});

  @override
  List<Object?> get props => [position];
}

class DetermineInitialCameraPositionEvent extends CameraPositionEvent {
  const DetermineInitialCameraPositionEvent():super();
}
class DetermineCameraPositionEvent extends CameraPositionEvent {
  const DetermineCameraPositionEvent(Position? position):super(position: position);
}