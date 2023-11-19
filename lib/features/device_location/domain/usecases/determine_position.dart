import 'package:geolocator/geolocator.dart';
import 'package:weather_app/features/device_location/domain/repositories/device_location_repository.dart';
import '../../../../core/usecase/usecase.dart';

class DeterminePositionUseCase implements UseCase< Position, void > {
  final DeviceLocationRepository _deviceLocationRepository;
  DeterminePositionUseCase(this._deviceLocationRepository);

  @override
  Future<Position> call({void params}) {
    return _deviceLocationRepository.determinePosition();
  }
}

