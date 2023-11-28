

import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class CameraPositionRepository {
 Future<CameraPosition> determineInitialCameraPosition(String position);

}
