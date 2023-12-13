// ignore_for_file: avoid_print

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/features/device_position/domain/usecases/determine_position.dart';
part 'device_position_event.dart';
part 'device_position_state.dart';

class DevicePositionBloc
    extends Bloc<DevicePositionEvent, DevicePositionState> {
  final DeterminePositionUseCase _determinePositionUseCase;

  DevicePositionBloc(
    this._determinePositionUseCase,
  ) : super(DevicePositionInitial()) {
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
      print('eldad');
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
        emit(DevicePositionError(e));
      }
    }
  }
}
