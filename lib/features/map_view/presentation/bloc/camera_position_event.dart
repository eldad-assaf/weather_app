part of 'camera_position_bloc.dart';

abstract class CameraPositionEvent extends Equatable {
  final LatLng? latLng;


  const CameraPositionEvent({this.latLng});

  @override
  List<Object?> get props => [latLng];
}

class DetermineInitialCameraPositionEvent extends CameraPositionEvent {
  const DetermineInitialCameraPositionEvent() : super();
}

class SaveLastCameraPositionToSfEvent extends CameraPositionEvent {
  const SaveLastCameraPositionToSfEvent(LatLng? latLng)
      : super(latLng: latLng);
}
