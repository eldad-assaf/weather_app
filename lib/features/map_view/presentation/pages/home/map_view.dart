import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_app/features/device_position/presentation/bloc/device_position_bloc.dart';
import 'package:weather_app/features/map_view/presentation/bloc/camera_position_bloc.dart';
import 'package:weather_app/main.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => MapViewState();
}

class MapViewState extends State<MapView> {
  GoogleMapController? _mapController;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          BlocConsumer<DevicePositionBloc, DevicePositionState>(
              listener: (context, state) {
            if (state is DevicePositionDone) {
              context
                  .read<CameraPositionBloc>()
                  .add(DetermineCameraPositionEvent(state.position));
            }
          }, builder: (context, state) {
            if (state is DevicePositionLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return BlocBuilder<CameraPositionBloc, CameraPositionState>(
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
                      child: Text(
                          'CameraPositionError ${state.error.toString()}'));
                } else if (state is CameraPositionDone) {
                  return GoogleMap(
                      mapType: MapType.hybrid,
                      initialCameraPosition: state.cameraPosition!,
                      onMapCreated: (GoogleMapController controller) async {
                        // Store the controller for later use
                        _mapController = controller;
                        _goToThePlace(cameraPosition: state.cameraPosition!);
                        // _mapController!.animateCamera(
                        //     CameraUpdate.newCameraPosition(
                        //         state.cameraPosition!));
                      });
                } else {
                  return Container(
                    color: Colors.red,
                  );
                }
              },
            );
          }),
          Positioned(
            top: 16,
            left: 16,
            child: GestureDetector(
              onTap: () {
                //Navigator.pop(context);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const Home()));
              },
              child: FaIcon(
                FontAwesomeIcons.arrowLeft,
                size: 30.sp,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: GestureDetector(
              onTap: () {
                context
                    .read<DevicePositionBloc>()
                    .add(const DeterminePositionEvent());
              },
              child: FaIcon(
                FontAwesomeIcons.locationArrow,
                size: 30.sp,
                color: Colors.white,
              ),
            ),
          ),
        ]),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          label: const Text('To the lake!'),
          icon: const Icon(Icons.directions_boat),
        ),
      ),
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
