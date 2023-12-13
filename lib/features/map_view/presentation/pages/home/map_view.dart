// ignore_for_file: avoid_print

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_app/components/reuseable_text.dart';
import 'package:weather_app/components/text_style.dart';
import 'package:weather_app/core/extensions/extension_methods.dart';
import 'package:weather_app/core/helpers/helpers_methods.dart';
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
  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

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
        child: Container(
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
          width: 35.sp,
          height: 35.sp,
          child: Center(
            child: FaIcon(
              FontAwesomeIcons.arrowLeft,
              size: 25.sp,
              color: Colors.black,
            ),
          ),
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
                    // print(state.toString());
                    // print('${state.error!.error}');
                    // print('${state.error!.message}');
                    // print('${state.error!.type}');
                    // print('${state.error!.response!.statusCode}'); //400
                    print(
                        '${state.error!.response!.data['error']['code']}'); //1006

                    print(
                        '${state.error!.response!.data['error']['message']}'); //No matching location found.
                    // print(state.error!.response!.toString());

                    // print('${state.error!.response!.statusMessage}');
                    final errorMsg = handleChatGPTApiErrors(
                        state.error?.response?.data['error']['code']);
                    return Container(
                      height: 550.sp,
                      color: Colors.red,
                      child: Center(
                        child: ReusableTextWithAutoSize(
                            text: errorMsg,
                            maxLines: 2,
                            minFontSize: 15,
                            style: appStyle(15, Colors.white, FontWeight.bold)),
                      ),
                    );
                  }
                },
              );
            });
      },
      label: const Text('Get weather'),
      icon: const FaIcon(FontAwesomeIcons.locationArrow),
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
      onCameraMove: (CameraPosition cameraPosition) {
        context.read<CameraPositionBloc>().add(
              SaveLastCameraPositionToSfEvent(
                LatLng(cameraPosition.target.latitude,
                    cameraPosition.target.longitude),
              ),
            );
      },
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
