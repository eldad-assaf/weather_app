import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/features/map_view/domain/repositories/camera_poistion_repository.dart';

class CameraPositionRepositoryImpl extends CameraPositionRepository {
  @override
  Future<CameraPosition> determineInitialCameraPosition() async {
    final sf = await SharedPreferences.getInstance();
    final lat = sf.getString('lat');
    final lng = sf.getString('lng');
    if (lat != null && lng != null) {
      return _buildCameraPoistion(
          lat: double.parse(lat), lng: double.parse(lng));
    } else {
      //jerusalem
      return _buildCameraPoistion(lat: 31.766982, lng: 35.213685);
    }
  }

  @override
  Future<CameraPosition> determineCameraPosition(Position position) async {
    //save the device position to sf
    final sf = await SharedPreferences.getInstance();
    await sf.setString('lat', position.latitude.toString());
    await sf.setString('lng', position.longitude.toString());
    return _buildCameraPoistion(
        lat: position.latitude, lng: position.longitude);
  }
}

CameraPosition _buildCameraPoistion({
  required double lat,
  required double lng,
}) {
  return CameraPosition(target: LatLng(lat, lng), zoom: 7);
}