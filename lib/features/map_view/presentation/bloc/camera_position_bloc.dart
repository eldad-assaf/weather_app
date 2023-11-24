import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'camera_position_event.dart';
part 'camera_position_state.dart';

class CameraPositionBloc extends Bloc<CameraPositionEvent, CameraPositionState> {
  CameraPositionBloc() : super(CameraPositionInitial()) {
    on<CameraPositionEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
