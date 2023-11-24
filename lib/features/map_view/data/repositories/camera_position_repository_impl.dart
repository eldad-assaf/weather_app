import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_app/features/map_view/domain/repositories/camera_poistion_repository.dart';

class CameraPositionRepositoryImpl extends CameraPositionRepository {
  @override
  Future<CameraPosition> determineInitialCameraPosition(String position) async {
    print('position from repo  $position');

    final latlng = parseLatLng(position);
    print(latlng);
    return CameraPosition(
        target: latlng ?? const LatLng(37.4219983, -122.0840000), zoom: 14);
  }
}

LatLng? parseLatLng(String input) {
  List<String> coordinates = input.split(',').map((e) => e.trim()).toList();

  if (coordinates.length != 2) {
    throw ArgumentError(
        'Invalid input format. Please provide latitude and longitude separated by a comma.');
  }

  double? latitude = double.tryParse(coordinates[0]);
  double? longitude = double.tryParse(coordinates[1]);

  if (latitude == null || longitude == null) {
    throw ArgumentError(
        'Invalid latitude or longitude format. Please provide valid numeric values.');
  }

  return LatLng(latitude, longitude);
}
