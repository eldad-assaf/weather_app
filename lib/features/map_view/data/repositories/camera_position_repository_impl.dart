// ignore_for_file: avoid_print

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/features/map_view/domain/repositories/camera_poistion_repository.dart';

class CameraPositionRepositoryImpl extends CameraPositionRepository {
  @override
  //**Checks in SF for the last CameraPosition - if not available then it shows 'Jerusalem on the map' */
  Future<CameraPosition> determineInitialCameraPosition() async {
    final sf = await SharedPreferences.getInstance();
    final lat = sf.getString('lat');
    final lng = sf.getString('lng');
    if (lat != null && lng != null) {
      return _buildCameraPoistion(
          lat: double.parse(lat), lng: double.parse(lng));
    } else {
      return _buildCameraPoistion(lat: 31.766982, lng: 35.213685);
    }
  }

  //**For saving the last CameraPosition of the map ' */

  @override
  Future<void> saveLastCameraPositionToSf(LatLng latLng) async {
    //save the device position to sf
    final sf = await SharedPreferences.getInstance();
    await sf.setString('lat', latLng.latitude.toString());
    await sf.setString('lng', latLng.longitude.toString());
  }
}

CameraPosition _buildCameraPoistion({
  required double lat,
  required double lng,
}) {
  return CameraPosition(target: LatLng(lat, lng), zoom: 7);
}
