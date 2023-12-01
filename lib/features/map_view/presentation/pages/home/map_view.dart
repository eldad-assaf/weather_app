import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_app/features/device_position/presentation/bloc/device_position_bloc.dart';
import 'package:weather_app/features/map_view/presentation/bloc/camera_position_bloc.dart';
import 'package:weather_app/features/map_view/presentation/widgets/weather_modal_sheet.dart';
import 'package:weather_app/features/realtime_weather/presentation/bloc/realtime_weather_bloc.dart';
import 'package:weather_app/features/realtime_weather/presentation/bloc/realtime_weather_event.dart';
import 'package:weather_app/features/realtime_weather/presentation/bloc/realtime_weather_state.dart';
import 'package:weather_app/main.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => MapViewState();
}

class MapViewState extends State<MapView> {
  GoogleMapController? _mapController;
  LatLng? middleOfTheMap;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Stack(children: [
          BlocBuilder<CameraPositionBloc, CameraPositionState>(
            builder: (context, state) {
              if (state is CameraPositionInitial) {
                //should not happen
                return const Center(child: Text('CameraPositionInitial'));
              }
              if (state is CameraPositionLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is CameraPositionError) {
                return Center(
                    child:
                        Text('CameraPositionError ${state.error.toString()}'));
              } else if (state is CameraPositionDone) {
                return buildMap(state: state);
              } else {
                return Container(
                  color: Colors.red,
                );
              }
            },
          ),
          backButton(),
     
          //No need for this because myLocationButtonEnabled: true,
          // Positioned(
          //   top: 16,
          //   right: 16,
          //   child: GestureDetector(
          //     onTap: () {
          //       context
          //           .read<DevicePositionBloc>()
          //           .add(const DeterminePositionEvent());
          //     },
          //     child: FaIcon(
          //       FontAwesomeIcons.locationArrow,
          //       size: 30.sp,
          //       color: Colors.white,
          //     ),
          //   ),
          // ),
        ]),
        floatingActionButton: buildFab(context),
      ),
    );
  }

  Positioned backButton() {
    return Positioned(
      top: 16,
      left: 16,
      child: GestureDetector(
        onTap: () {
          //Navigator.pop(context);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const Home()));
        },
        child: FaIcon(
          FontAwesomeIcons.arrowLeft,
          size: 30.sp,
          color: Colors.white,
        ),
      ),
    );
  }

//Do not move this function to another file, it causes issues
  FloatingActionButton buildFab(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () async {
        context
            .read<RealtimeWeatherBloc>()
            .add(FetchRealtimeWeatherEvent(middleOfTheMap!.asString()));
        await showModalBottomSheet(
            useSafeArea: true,
            //barrierColor: Colors.blue,
            isScrollControlled: true,
            showDragHandle: true,
            context: context,
            builder: (context) {
              return BlocBuilder<RealtimeWeatherBloc, RealtimeWeatherState>(
                builder: (context, state) {
                  if (state is RealtimeWeatherLoading) {
                    return Container();
                  } else if (state is RealtimeWeatherDone) {
                    return WeatherModalSheet(
                      realtimeWeather: state.realtimeWeather!,
                    );
                  } else {
                    return Container(
                      height: 550.sp,
                      color: Colors.red,
                    );
                  }
                },
              );
            });
      },
      label: const Text('Get weather'),
      icon: const Icon(Icons.directions_boat),
    );
  }

  GoogleMap buildMap({required CameraPositionState state}) {
    return GoogleMap(
      mapType: MapType.hybrid,
      initialCameraPosition: state.cameraPosition!,
      onMapCreated: (GoogleMapController controller) async {
        _mapController = controller;
        _goToThePlace(cameraPosition: state.cameraPosition!);
      },
      myLocationButtonEnabled: true,
      myLocationEnabled: true,
      onCameraIdle: () async {
        middleOfTheMap =
            await _mapController!.getLatLng(const ScreenCoordinate(x: 0, y: 0));
      },
      onCameraMove: (cameraPosition) {},
    );
  }

  Future<void> _goToThePlace({required CameraPosition cameraPosition}) async {
    try {
      await _mapController!
          .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    } catch (e) {
      print(e.toString());
    }
  }
}
