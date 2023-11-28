import 'package:weather_app/features/device_position/domain/repositories/device_location_repository.dart';
import '../../../../core/usecase/usecase.dart';

class SaveLastPositionUseCase implements UseCase<void, String> {
  final DevicePositionRepository _devicePositionRepository;
  SaveLastPositionUseCase(this._devicePositionRepository);

  @override
  Future<void> call({String? params}) {
   return  _devicePositionRepository.savePositionInSf(params!);
  }
}

