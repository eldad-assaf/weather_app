// ignore_for_file: avoid_print

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/features/device_location/domain/usecases/determine_position.dart';
import 'package:geocoding/geocoding.dart';
part 'device_location_event.dart';
part 'device_location_state.dart';

class DeviceLocationBloc
    extends Bloc<DeviceLocationEvent, DeviceLocationState> {
  final DeterminePositionUseCase _determinePositionUseCase;

  DeviceLocationBloc(this._determinePositionUseCase)
      : super(DeviceLocationInitial()) {
    on<DeterminePositionEvent>(onDeterminePosition);
    on<GeocodeCityNameEvent>(onGeocodeCityName);
  }

  void onDeterminePosition(
      DeterminePositionEvent event, Emitter<DeviceLocationState> emit) async {
    try {
      final position = await _determinePositionUseCase();
      emit(DeviceLocationDone(position));
      add(const GeocodeCityNameEvent());
    } catch (e) {
      //** This catch block catches errors if the permissions are denied or location services are off  */
      print('onDeterminePosition ERROR : ');
      print(e.toString());

      emit(DeviceLocationError(e));
    }
  }

  void onGeocodeCityName(
      GeocodeCityNameEvent event, Emitter<DeviceLocationState> emit) async {
    //**// **this is called only if the position of the user was retrived successfully
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          state.position!.latitude, state.position!.longitude);
      if (placemarks[0].locality != null) {
        print(placemarks[0].locality);
        final sf = await SharedPreferences.getInstance();
        await sf.setString(
          'cityName',
          placemarks[0].locality!,
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
