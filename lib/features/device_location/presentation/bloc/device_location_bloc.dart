// ignore_for_file: avoid_print

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/features/device_location/domain/usecases/determine_position.dart';
part 'device_location_event.dart';
part 'device_location_state.dart';

class DevicePositionBloc
    extends Bloc<DevicePositionEvent, DevicePoditionState> {
  final DeterminePositionUseCase _determinePositionUseCase;

  DevicePositionBloc(this._determinePositionUseCase)
      : super(DeviceLocationInitial()) {
    on<DeterminePositionEvent>(onDeterminePosition);
  }

  void onDeterminePosition(
      DeterminePositionEvent event, Emitter<DevicePoditionState> emit) async {
    try {
      emit(const DevicePositionLoading());

      bool isLocationServiceEnabled =
          await Geolocator.isLocationServiceEnabled();
      if (!isLocationServiceEnabled) {
        emit(const DeviceLocationServicesNotEnabled(
            'Location services are off'));
      }
      final position = await _determinePositionUseCase();
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
