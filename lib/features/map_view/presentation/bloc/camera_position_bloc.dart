import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_app/features/map_view/domain/usecases/determine_camera_position.dart';

part 'camera_position_event.dart';
part 'camera_position_state.dart';

class CameraPositionBloc
    extends Bloc<CameraPositionEvent, CameraPositionState> {
  final DetermineCameraPositionUseCase _determineCameraPositionUseCase;

  CameraPositionBloc(this._determineCameraPositionUseCase)
      : super(CameraPositionInitial()) {
    on<DetermineInitialCameraPositionEvent>(onDetermineInitialCameraPosition);
  }

  void onDetermineInitialCameraPosition(
      DetermineInitialCameraPositionEvent event,
      Emitter<CameraPositionState> emit) async {
    try {
      final cameraPosition =
          await _determineCameraPositionUseCase(params: event.position);

      print('cameraPosition bloc : $cameraPosition');
      // const CameraPosition cameraPosition2 = CameraPosition(
      //   target: LatLng(22.34563, 33.445533),
      //   zoom: 14.4746,
      // );
      emit(CameraPositionDone(cameraPosition));
    } catch (e) {
      print(e.toString());
    }
  }
}
