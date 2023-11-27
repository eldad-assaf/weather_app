import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_app/main.dart';

//first, tries to fetch the last position from the sf
//if it is null then the place that the map shows is tel- aviv

//until here there is no need for any location services or permissions



class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              FutureBuilder<bool>(
                  future: Future(() => true),
                  builder: (context, snapshot) {
                    return const GoogleMap(
                      initialCameraPosition: CameraPosition(
                          target: LatLng(32.1729633, 34.9079517), zoom: 15),
                      scrollGesturesEnabled: true,
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
      ),
    );
  }
}


// class MapView extends StatelessWidget {
//   const MapView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<CameraPositionBloc, CameraPositionState>(
//       builder: (context, state) {
//         if (state is CameraPositionInitial) {
//           BlocProvider.of<DevicePositionBloc>(context)
//               .add(const DeterminePositionEvent());
//           print(state);
//           return Container();
//         }
//         if (state is CameraPositionDone) {
//           return Scaffold(
//             body: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Stack(
//                 children: [
//                   GoogleMap(
//                     initialCameraPosition: state.cameraPosition!,
//                     scrollGesturesEnabled: true,
//                   ),
//                   Positioned(
//                     top: 16,
//                     left: 16,
//                     child: GestureDetector(
//                       onTap: () {
//                         //Navigator.pop(context);
//                         Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => const Home()));
//                       },
//                       child: FaIcon(
//                         FontAwesomeIcons.arrowLeft,
//                         size: 30.sp,
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     top: 16,
//                     right: 16,
//                     child: GestureDetector(
//                       onTap: () {},
//                       child: FaIcon(
//                         FontAwesomeIcons.locationArrow,
//                         size: 30.sp,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         } else {
//           return Container();
//         }
//       },
//     );
//   }
// }
