import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_app/features/map_view/domain/repositories/camera_poistion_repository.dart';
import '../../../../core/usecase/usecase.dart';

class DetermineCameraPositionUseCase implements UseCase<CameraPosition, String> {
   final CameraPositionRepository _cameraPositionRepository;
  DetermineCameraPositionUseCase(this._cameraPositionRepository);
  
  @override
  Future<CameraPosition> call({String? params}) {
  return _cameraPositionRepository.determineInitialCameraPosition(params!);
  }


}



