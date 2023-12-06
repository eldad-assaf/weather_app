import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/components/alert_dialog_model.dart';
import 'package:weather_app/components/reuseable_text.dart';
import 'package:weather_app/components/text_style.dart';
import 'package:weather_app/features/device_position/presentation/bloc/device_position_bloc.dart';
import 'package:weather_app/features/map_view/presentation/bloc/camera_position_bloc.dart';
import 'package:weather_app/features/map_view/presentation/pages/home/map_view.dart';
import 'package:weather_app/features/realtime_weather/presentation/bloc/realtime_weather_bloc.dart';
import 'package:weather_app/features/realtime_weather/presentation/bloc/realtime_weather_event.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    super.key,
  });
  @override
  Size get preferredSize => Size(56, AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      // forceMaterialTransparency: true,
      elevation: 3,
      systemOverlayStyle:
          const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      title: ReusableText(
          text: 'Weather', style: appStyle(18, Colors.white, FontWeight.w300)),
      actions: [
        IconButton(
            color: Colors.red,
            onPressed: () async {
              SharedPreferences sf = await SharedPreferences.getInstance();
              await sf.clear();
            },
            icon: const Icon(Icons.delete)),
        BlocListener<DevicePositionBloc, DevicePositionState>(
          listener: (context, state) {
            if (state is DevicePositionDone) {
              BlocProvider.of<RealtimeWeatherBloc>(context)
                  .add(FetchRealtimeWeatherEvent(state.position!.asString()));
            }
            if (state is DeviceLocationServicesNotEnabled) {
              const AlertDialogModel(
                      message:
                          'Please go to settings and enable the device location service',
                      buttons: {'ok': true},
                      title: 'Location service')
                  .present(context)
                  .then((goToSettings) async {
                if (goToSettings == true) {
                  await Geolocator.openLocationSettings();
                }
              });
            }
            if (state is DeviceLocationPermissionsDenied) {
              const AlertDialogModel(
                      message: 'You need to give the app location permissions',
                      buttons: {'ok': true},
                      title: 'Permissions needed')
                  .present(context)
                  .then((requestAgain) async {
                if (requestAgain == true) {
                  await Geolocator.openLocationSettings();
                }
              });
            }
            if (state is DeviceLocationPermissionsDeniedForever) {
              const AlertDialogModel(
                      message: 'You need to give the app location permissions',
                      buttons: {'ok': true},
                      title: 'Permissions needed')
                  .present(context)
                  .then((requestAgain) async {
                if (requestAgain == true) {
                  await Geolocator.openAppSettings();
                }
              });
            }
          },
          child: BlocBuilder<DevicePositionBloc, DevicePositionState>(
            builder: (context, state) {
              if (state is DevicePositionLoading) {
                return const Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: CircularProgressIndicator(),
                );
              }
              return InkWell(
                onTap: () {
                  BlocProvider.of<DevicePositionBloc>(context)
                      .add(const DeterminePositionEvent());
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: FaIcon(
                    FontAwesomeIcons.locationArrow,
                    size: 33.sp,
                    color: Colors.white,
                  ),
                ),
              );
            },
          ),
        ),
        IconButton(
            onPressed: () {
              context
                  .read<CameraPositionBloc>()
                  .add(const DetermineInitialCameraPositionEvent());
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (BuildContext context) {
                return const MapView();
              }));
            },
            icon: FaIcon(
              FontAwesomeIcons.map,
              size: 33.sp,
              color: Colors.white,
            ))
      ],
    );
  }
}
