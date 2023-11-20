import 'package:geolocator/geolocator.dart';
import 'package:weather_app/features/device_location/domain/repositories/device_location_repository.dart';
import '../../../../core/usecase/usecase.dart';

class FetchCityNameUseCase implements UseCase<String?, Position?> {
  final DeviceLocationRepository _deviceLocationRepository;
  FetchCityNameUseCase(this._deviceLocationRepository);

  @override
  Future<String?> call({Position? params}) {
    return _deviceLocationRepository.fetchCityName(params);
  }
}



