// ignore_for_file: avoid_print

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/features/map_view/domain/usecases/determine_camera_position.dart';
part 'camera_position_event.dart';
part 'camera_position_state.dart';

class CameraPositionBloc
    extends Bloc<CameraPositionEvent, CameraPositionState> {
  final DetermineCameraPositionUseCase _determineCameraPositionUseCase;

  CameraPositionBloc(this._determineCameraPositionUseCase)
      : super(CameraPositionInitial()) {
    on<DetermineInitialCameraPositionEvent>(onDetermineInitialCameraPosition);
    on<DetermineCameraPositionEvent>(onDetermineCameraPosition);
  }

  void onDetermineInitialCameraPosition(
    DetermineInitialCameraPositionEvent event,
    Emitter<CameraPositionState> emit,
  ) async {
    try {
//checks if the last position is stored in sf
      emit(CameraPositionLoading());
      final sf = await SharedPreferences.getInstance();
      final lat = sf.getString('lat');
      final lng = sf.getString('lng');
      if (lat != null && lng != null) {
        //build camera position for last place
        final cameraPosition = _buildCameraPoistion(lat: lat, lng: lng);
        emit(CameraPositionDone(cameraPosition));
      } else {
        //build camera position for Jerusalem (default)
        final cameraPosition =
            _buildCameraPoistion(lat: 31.766982, lng: 35.213685);
        emit(CameraPositionDone(cameraPosition));
      }
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
      //update sf 
    } catch (e) {
      emit(CameraPositionError(e));
      print(e.toString());
    }
  }

  CameraPosition _buildCameraPoistion({required lat, required lng}) {
    return CameraPosition(target: LatLng(lat, lng), zoom: 13);
  }
}
