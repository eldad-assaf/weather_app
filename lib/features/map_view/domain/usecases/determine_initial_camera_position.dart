import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_app/features/map_view/domain/repositories/camera_poistion_repository.dart';
import '../../../../core/usecase/usecase.dart';

class DetermineInitialCameraPositionUseCase implements UseCase<CameraPosition, void> {
   final CameraPositionRepository _cameraPositionRepository;
  DetermineInitialCameraPositionUseCase(this._cameraPositionRepository);
  
  @override
  Future<CameraPosition> call({void params}) {
  return _cameraPositionRepository.determineInitialCameraPosition();
  }


}



