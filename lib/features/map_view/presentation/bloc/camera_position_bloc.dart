// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:ffi';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
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
        print(lat);
        print(lng);

        final cameraPosition = _buildCameraPoistion(
            lat: double.parse(lat), lng: double.parse(lng));
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
      emit(CameraPositionLoading());
      //save the device position to sf
      final sf = await SharedPreferences.getInstance();
      await sf.setString('lat', event.position!.latitude.toString());
      await sf.setString('lng', event.position!.longitude.toString());
      final cameraPosition = _buildCameraPoistion(
          lat: event.position!.latitude, lng: event.position!.longitude);

      emit(CameraPositionDone(cameraPosition));
    } catch (e) {
      print('error');
      emit(CameraPositionError(e));
      print(e.toString());
    }
  }

  CameraPosition _buildCameraPoistion({
    required double lat,
    required double lng,
  }) {
    return CameraPosition(target: LatLng(lat, lng), zoom: 13);
  }
}
