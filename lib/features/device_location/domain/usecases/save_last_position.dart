import 'package:weather_app/features/device_location/domain/repositories/device_location_repository.dart';
import '../../../../core/usecase/usecase.dart';

class SaveLastPositionUseCase implements UseCase<void, String> {
  final DeviceLocationRepository _deviceLocationRepository;
  SaveLastPositionUseCase(this._deviceLocationRepository);

  @override
  Future<void> call({String? params}) {
   return  _deviceLocationRepository.savePositionInSf(params!);
  }
}

