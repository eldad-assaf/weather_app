// ignore_for_file: avoid_print

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_app/features/map_view/domain/usecases/determine_camera_position.dart';
import 'package:weather_app/features/map_view/domain/usecases/determine_initial_camera_position.dart';
part 'camera_position_event.dart';
part 'camera_position_state.dart';

class CameraPositionBloc
    extends Bloc<CameraPositionEvent, CameraPositionState> {
  final DetermineInitialCameraPositionUseCase
      _determineInitialCameraPositionUseCase;
  final SaveLastCameraPositionToSfUseCase _saveLastCameraPositionToSfUseCase;

  CameraPositionBloc(this._determineInitialCameraPositionUseCase,
      this._saveLastCameraPositionToSfUseCase)
      : super(CameraPositionInitial()) {
    on<DetermineInitialCameraPositionEvent>(onDetermineInitialCameraPosition);
    on<SaveLastCameraPositionToSfEvent>(onSaveLastCameraPositionToSf);
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

  void onSaveLastCameraPositionToSf(
    SaveLastCameraPositionToSfEvent event,
    Emitter<CameraPositionState> emit,
  ) async {
    try {
      await _saveLastCameraPositionToSfUseCase(params: event.latLng);
    } catch (e) {
      print(e.toString());
    }
  }
}
