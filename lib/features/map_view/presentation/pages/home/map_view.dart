// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class MapView extends StatefulWidget {
//   const MapView({super.key});

//   @override
//   State<MapView> createState() => MapViewState();
// }

// class MapViewState extends State<MapView> {
//   final Completer<GoogleMapController> _controller =
//       Completer<GoogleMapController>();

//   static const CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(37.42796133580664, -122.085749655962),
//     zoom: 14.4746,
//   );

//   static const CameraPosition _kLake = CameraPosition(
//       bearing: 192.8334901395799,
//       target: LatLng(37.43296265331129, -122.08832357078792),
//       tilt: 59.440717697143555,
//       zoom: 19.151926040649414);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GoogleMap(
//         mapType: MapType.hybrid,
//         initialCameraPosition: _kGooglePlex,
//         onMapCreated: (GoogleMapController controller) {
//           _controller.complete(controller);
//         },
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: _goToTheLake,
//         label: const Text('To the lake!'),
//         icon: const Icon(Icons.directions_boat),
//       ),
//     );
//   }

//   Future<void> _goToTheLake() async {
//     final GoogleMapController controller = await _controller.future;
//     await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_app/features/device_location/presentation/bloc/device_location_bloc.dart';
import 'package:weather_app/features/map_view/presentation/bloc/camera_position_bloc.dart';
import 'package:weather_app/main.dart';

class MapView extends StatelessWidget {
  const MapView({super.key});
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(32.1848960, 34.9141710),
    zoom: 14.4746,
  );
  @override
  Widget build(BuildContext context) {
    return BlocListener<DevicePositionBloc, DevicePositionState>(
      listener: (context, state) {
        if (state is DevicePositionDone) {
          print(state);
          print('state is DevicePositionDone');
          BlocProvider.of<CameraPositionBloc>(context)
              .add(DetermineInitialCameraPositionEvent(state.position));
        } else {
          print(state);
        }
      },
      child: BlocBuilder<CameraPositionBloc, CameraPositionState>(
        builder: (context, state) {
          print(state);
          if (state is CameraPositionInitial) {
            BlocProvider.of<DevicePositionBloc>(context)
                .add(const DeterminePositionEvent());
            return const CircularProgressIndicator();
          }
          if (state is CameraPositionDone) {
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    GoogleMap(
                      initialCameraPosition: state.cameraPosition!,
                      scrollGesturesEnabled: true,
                    ),
                    Positioned(
                      top: 16,
                      left: 16,
                      child: GestureDetector(
                        onTap: () {
                          //Navigator.pop(context);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Home()));
                        },
                        child: FaIcon(
                          FontAwesomeIcons.arrowLeft,
                          size: 30.sp,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 16,
                      right: 16,
                      child: GestureDetector(
                        onTap: () {},
                        child: FaIcon(
                          FontAwesomeIcons.locationArrow,
                          size: 30.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
