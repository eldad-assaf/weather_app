// ignore_for_file: avoid_print

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/features/device_position/domain/usecases/determine_position.dart';
part 'device_position_event.dart';
part 'device_position_state.dart';

extension PostitionAsString on Position {
  String asString() {
    return '${latitude.toStringAsFixed(7)}, ${longitude.toStringAsFixed(7)}';
  }
}

extension LatLngAsString on LatLng {
  String asString() {
    String latitudeString = latitude.toStringAsFixed(14);
    String longitudeString = longitude.toStringAsFixed(14);

    return '$latitudeString, $longitudeString';
  }
}

class DevicePositionBloc
    extends Bloc<DevicePositionEvent, DevicePositionState> {
  final DeterminePositionUseCase _determinePositionUseCase;

  DevicePositionBloc(
    this._determinePositionUseCase,
  ) : super(DeviceLocationInitial()) {
    on<DeterminePositionEvent>(onDeterminePosition);
  }

  void onDeterminePosition(
      DeterminePositionEvent event, Emitter<DevicePositionState> emit) async {
    try {
      emit(const DevicePositionLoading());
      bool isLocationServiceEnabled =
          await Geolocator.isLocationServiceEnabled();
      if (!isLocationServiceEnabled) {
        emit(const DeviceLocationServicesNotEnabled(
            'Location services are off'));
      }
      final position = await _determinePositionUseCase();

      SharedPreferences sf = await SharedPreferences.getInstance();
      await sf.setString(
          'latlngAsString', '${position.latitude},${position.longitude}');

      emit(DevicePositionDone(position));
    } catch (e) {
      final permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        emit(const DeviceLocationPermissionsDenied(
            'Location permissions are denied.'));
      } else if (permission == LocationPermission.deniedForever) {
        emit(const DeviceLocationPermissionsDeniedForever(
            'Location permissions are permanently denied, we cannot request permissions.'));
      } else {
        emit(DeviceLocationError(e));
      }
    }
  }
}
