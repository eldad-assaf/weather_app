import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

extension PostitionAsString on Position {
  String asString() {
    return '${latitude.toStringAsFixed(7)}, ${longitude.toStringAsFixed(7)}';
  }
}

extension LatLngAsString on LatLng {
  String asString() {
    String latitudeString = latitude.toStringAsFixed(14);
    String longitudeString = longitude.toStringAsFixed(14);

    return '$latitudeString, $longitudeString';
  }
}
