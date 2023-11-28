import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/features/device_position/presentation/bloc/device_position_bloc.dart';
import 'package:weather_app/features/map_view/presentation/bloc/camera_position_bloc.dart';
import 'package:weather_app/main.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  Future<String?> getLastPositionFromSf() async {
    final sf = await SharedPreferences.getInstance();
    return sf.getString('position');
  }

  // final CameraPosition(
  //                             target = const LatLng(32.1848960, 34.9141710),
  //                             zoom = 14.8);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DevicePositionBloc, DevicePositionState>(
      listener: (context, state) {
        if (state is DevicePositionDone) {
          print('DevicePositionState : DevicePositionDone  ');
          context
              .read<CameraPositionBloc>()
              .add(DetermineInitialCameraPositionEvent(state.position));
        }
      },
      builder: (context, state) {
        return BlocConsumer<CameraPositionBloc, CameraPositionState>(
          listener: (context, state) {},
          builder: (context, state) {
            return SafeArea(
              child: Scaffold(
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      state is CameraPositionDone
                          ? GoogleMap(
                              initialCameraPosition: state.cameraPosition!)
                          : Container(),
                      state is CameraPositionInitial
                          ? const GoogleMap(
                              initialCameraPosition: CameraPosition(
                                  target: LatLng(32.1848960, 34.9141710)))
                          : Container(),
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
                          onTap: () {
                            context
                                .read<DevicePositionBloc>()
                                .add(const DeterminePositionEvent());
                          },
                          child: FaIcon(
                            FontAwesomeIcons.locationArrow,
                            size: 30.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

// class MapView extends StatefulWidget {
//   const MapView({super.key});

//   @override
//   State<MapView> createState() => _MapViewState();
// }

// class _MapViewState extends State<MapView> {
//   Future<String?> getLastPositionFromSf() async {
//     final sf = await SharedPreferences.getInstance();
//     return sf.getString('position');
//   }

//   // final CameraPosition(
//   //                             target = const LatLng(32.1848960, 34.9141710),
//   //                             zoom = 14.8);

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Stack(
//             children: [
//               BlocConsumer<DevicePositionBloc, DevicePositionState>(
//                 listener: (context, state) {
//                   if (state is DevicePositionDone) {
//                     print('DevicePositionState : DevicePositionDone  ');
//                     context.read<CameraPositionBloc>().add(
//                         DetermineInitialCameraPositionEvent(state.position));
//                   }
//                 },
//                 builder: (context, state) {
//                   return BlocConsumer<CameraPositionBloc, CameraPositionState>(
//                     listener: (context, state) {
//                       print('CameraPositionState : ${state.cameraPosition}  ');
//                       // TODO: implement listener
//                     },
//                     builder: (context, state) {
//                       if (state is CameraPositionInitial) {
//                         const CameraPosition initialCameraPosition =
//                             CameraPosition(
//                           target: LatLng(32.1848960, 34.9141710),
//                           zoom: 10,
//                         );
//                         return Container(
//                           color: Colors.white,
//                         );
//                         // return const GoogleMap(
//                         //     initialCameraPosition: initialCameraPosition);
//                       } else if (state is CameraPositionDone) {
//                         print('state is CameraPositionDone ');
//                         return Container(
//                           color: Colors.green,
//                         );
//                         // return const GoogleMap(
//                         //   initialCameraPosition: CameraPosition(
//                         //     target: LatLng(30.1848960, 32.9141710),
//                         //   ),
//                         //   scrollGesturesEnabled: true,
//                         // );
//                       } else {
//                         return Container(
//                           color: Colors.green,
//                         );
//                       }
//                     },
//                   );
//                 },
//               ),
//               Positioned(
//                 top: 16,
//                 left: 16,
//                 child: GestureDetector(
//                   onTap: () {
//                     //Navigator.pop(context);
//                     Navigator.pushReplacement(context,
//                         MaterialPageRoute(builder: (context) => const Home()));
//                   },
//                   child: FaIcon(
//                     FontAwesomeIcons.arrowLeft,
//                     size: 30.sp,
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: 16,
//                 right: 16,
//                 child: GestureDetector(
//                   onTap: () {
//                     context
//                         .read<DevicePositionBloc>()
//                         .add(const DeterminePositionEvent());
//                   },
//                   child: FaIcon(
//                     FontAwesomeIcons.locationArrow,
//                     size: 30.sp,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
