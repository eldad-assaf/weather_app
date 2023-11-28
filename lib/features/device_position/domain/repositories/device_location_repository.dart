import 'package:geolocator/geolocator.dart';

abstract class DevicePositionRepository {
  Future<Position> determinePosition();
  Future<void> savePositionInSf(String position);
}
