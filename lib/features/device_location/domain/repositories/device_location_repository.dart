import 'package:geolocator/geolocator.dart';

abstract class DeviceLocationRepository {
  Future<Position> determinePosition ();
  Future<String?> fetchCityName(Position? position);
}
