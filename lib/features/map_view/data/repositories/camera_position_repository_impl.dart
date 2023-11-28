import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_app/features/map_view/domain/repositories/camera_poistion_repository.dart';

class CameraPositionRepositoryImpl extends CameraPositionRepository {
  @override
  Future<CameraPosition> determineInitialCameraPosition(String position) async {
    final latlng = parseLatLng(position);
    return CameraPosition(
      target: latlng ?? const LatLng(32.084304, 34.772472), //  Tel-aviv
      zoom: 14.4746,
    );
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
