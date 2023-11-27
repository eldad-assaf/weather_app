import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              const GoogleMap(
                initialCameraPosition:
                    CameraPosition(target: LatLng(32.1848960, 34.9141710)),
                scrollGesturesEnabled: true,
              ),
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
