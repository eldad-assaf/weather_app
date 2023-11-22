import 'package:geolocator/geolocator.dart';

abstract class DeviceLocationRepository {
  Future<Position> determinePosition();
  Future<void> savePositionInSf(String position);
}
