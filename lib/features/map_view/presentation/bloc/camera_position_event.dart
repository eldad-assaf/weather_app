part of 'camera_position_bloc.dart';

abstract class CameraPositionEvent extends Equatable {
  final String? position;
  const CameraPositionEvent({this.position});

  @override
  List<Object?> get props => [position];
}

class DetermineInitialCameraPositionEvent extends CameraPositionEvent {
  const DetermineInitialCameraPositionEvent(String? position):super(position: position);
}
