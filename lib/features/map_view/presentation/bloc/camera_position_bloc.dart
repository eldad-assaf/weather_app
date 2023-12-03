// ignore_for_file: avoid_print

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_app/features/map_view/domain/usecases/determine_camera_position.dart';
import 'package:weather_app/features/map_view/domain/usecases/determine_initial_camera_position.dart';
part 'camera_position_event.dart';
part 'camera_position_state.dart';

class CameraPositionBloc
    extends Bloc<CameraPositionEvent, CameraPositionState> {
  final DetermineInitialCameraPositionUseCase
      _determineInitialCameraPositionUseCase;
  final DetermineCameraPositionUseCase _determineCameraPositionUseCase;

  CameraPositionBloc(this._determineInitialCameraPositionUseCase,
      this._determineCameraPositionUseCase)
      : super(CameraPositionInitial()) {
    on<DetermineInitialCameraPositionEvent>(onDetermineInitialCameraPosition);
    on<DetermineCameraPositionEvent>(onDetermineCameraPosition);
  }

  void onDetermineInitialCameraPosition(
    DetermineInitialCameraPositionEvent event,
    Emitter<CameraPositionState> emit,
  ) async {
    try {
      emit(CameraPositionLoading());

      final initialCameraPosition =
          await _determineInitialCameraPositionUseCase();
      emit(CameraPositionDone(initialCameraPosition));
    } catch (e) {
      emit(CameraPositionError(e));
      print(e.toString());
    }
  }

  void onDetermineCameraPosition(
    DetermineCameraPositionEvent event,
    Emitter<CameraPositionState> emit,
  ) async {
    try {
      emit(CameraPositionLoading());

      final cameraPosition =
          await _determineCameraPositionUseCase(params: event.position);

      emit(CameraPositionDone(cameraPosition));
    } catch (e) {
      emit(CameraPositionError(e));
      print(e.toString());
    }
  }
}
