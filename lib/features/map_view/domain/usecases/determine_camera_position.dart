import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_app/features/map_view/domain/repositories/camera_poistion_repository.dart';
import '../../../../core/usecase/usecase.dart';


class SaveLastCameraPositionToSfUseCase implements UseCase<void, LatLng> {
  final CameraPositionRepository _cameraPositionRepository;
  SaveLastCameraPositionToSfUseCase(this._cameraPositionRepository);

  @override
  Future<void> call({LatLng? params}) {
    return _cameraPositionRepository.saveLastCameraPositionToSf(params!);
  }
}
