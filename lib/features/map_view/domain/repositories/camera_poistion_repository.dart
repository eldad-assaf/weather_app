import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class CameraPositionRepository {
  Future<CameraPosition> determineInitialCameraPosition();
  Future<CameraPosition> determineCameraPosition(Position position);
}
