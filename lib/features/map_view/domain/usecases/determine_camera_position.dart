import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_app/features/map_view/domain/repositories/camera_poistion_repository.dart';
import '../../../../core/usecase/usecase.dart';

class DetermineCameraPositionUseCase implements UseCase<CameraPosition, Position> {
   final CameraPositionRepository _cameraPositionRepository;
  DetermineCameraPositionUseCase(this._cameraPositionRepository);
  
  @override
  Future<CameraPosition> call({Position? params}) {
  return _cameraPositionRepository.determineCameraPosition(params!);
  }


}



