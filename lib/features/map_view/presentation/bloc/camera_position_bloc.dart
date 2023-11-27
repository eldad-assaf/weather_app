// ignore_for_file: avoid_print

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
    print('onDetermineInitialCameraPosition position : ${event.position}');
    try {
      final cameraPosition =
          await _determineCameraPositionUseCase(params: event.position);
      emit(CameraPositionDone(cameraPosition));
    } catch (e) {
      print(e.toString());
    }
  }
}
