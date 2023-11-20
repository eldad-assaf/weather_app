// ignore_for_file: avoid_print

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/features/device_location/domain/usecases/determine_position.dart';
import 'package:weather_app/features/device_location/domain/usecases/fetch_city_name.dart';
part 'device_location_event.dart';
part 'device_location_state.dart';

class DeviceLocationBloc
    extends Bloc<DeviceLocationEvent, DeviceLocationState> {
  final DeterminePositionUseCase _determinePositionUseCase;
  final FetchCityNameUseCase _fetchCityNameUseCase;

  DeviceLocationBloc(this._determinePositionUseCase, this._fetchCityNameUseCase)
      : super(DeviceLocationInitial()) {
    on<DeterminePositionEvent>(onDeterminePosition);
    on<GeocodeCityNameEvent>(onGeocodeCityName);
  }

  void onDeterminePosition(
      DeterminePositionEvent event, Emitter<DeviceLocationState> emit) async {
    try {
      emit(const DeviceLocationLoading());
      final position = await _determinePositionUseCase();
      emit(DevicePositionDone(position));
      add(const GeocodeCityNameEvent());
    } catch (e) {
      final permission = await Geolocator.requestPermission();
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

  void onGeocodeCityName(
      GeocodeCityNameEvent event, Emitter<DeviceLocationState> emit) async {
    try {
      final String? cityName = await _fetchCityNameUseCase.call();
      if (cityName == null) {
        emit(const DeviceLocationError(
            'Unable to retrive city name from coordinates'));
      } else {
        emit(DeviceCityNameDone(cityName));
      }
    } catch (e) {
      print(e.toString());
      emit(DeviceLocationError(e));
    }
  }
}

     // await Geolocator.openAppSettings();
    // await Geolocator.openLocationSettings();