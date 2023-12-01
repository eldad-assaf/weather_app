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
import 'package:weather_app/config/theme/app_background.dart';
import 'package:weather_app/features/device_position/presentation/bloc/device_position_bloc.dart';
import 'package:weather_app/features/map_view/presentation/bloc/camera_position_bloc.dart';
import 'package:weather_app/features/map_view/presentation/pages/home/map_view.dart';
import 'package:weather_app/features/realtime_weather/presentation/bloc/realtime_weather_event.dart';
import 'package:weather_app/injection_container.dart';
import 'features/realtime_weather/presentation/bloc/realtime_weather_bloc.dart';
import 'features/realtime_weather/presentation/pages/home/realtime_weather.dart';

void main() async {
  await initializeDependencies();
  Bloc.observer = const AppBlocObserver();

  runApp(const MyApp());
}

class AppBlocObserver extends BlocObserver {
  /// {@macro app_bloc_observer}
  const AppBlocObserver();

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RealtimeWeatherBloc>(
          create: (context) => sl()..add(const FetchRealtimeWeatherEvent(null)),
        ),
        BlocProvider<DevicePositionBloc>(
          create: (context) => sl(),
        ),
        BlocProvider<CameraPositionBloc>(
          create: (context) => sl(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(393, 851), // PIXEL 5
        child: MaterialApp(
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          home: const Home(),
        ),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          // forceMaterialTransparency: true,
          elevation: 0,
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
          title: ReusableText(
              text: 'Weather',
              style: appStyle(25, Colors.white, FontWeight.w300)),
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
                  BlocProvider.of<RealtimeWeatherBloc>(context).add(
                      FetchRealtimeWeatherEvent(state.position!.asString()));
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
                          message:
                              'You need to give the app location permissions',
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
                          message:
                              'You need to give the app location permissions',
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
        ),
        body: const BackGround(
          isDay: '1',
        ),
        // body: PageView(
        //   padEnds: false,
        //   controller: controller,
        //   children: const <Widget>[
        //     RealtimeWeather(),
        //     //  MapView(),
        //     Center(
        //       child: Text('Second Page'),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
