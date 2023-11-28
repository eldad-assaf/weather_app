import 'package:geolocator/geolocator.dart';
import 'package:weather_app/features/device_position/domain/repositories/device_location_repository.dart';
import '../../../../core/usecase/usecase.dart';

class DeterminePositionUseCase implements UseCase<Position, void> {
  final DevicePositionRepository _devicePositionRepository;
  DeterminePositionUseCase(this._devicePositionRepository);

  @override
  Future<Position> call({void params}) {
    return _devicePositionRepository.determinePosition();
  }
}
