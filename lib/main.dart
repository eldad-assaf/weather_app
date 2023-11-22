import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/components/alert_dialog_model.dart';
import 'package:weather_app/features/device_location/presentation/bloc/device_location_bloc.dart';
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
    print(change.toString());
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition.toString());
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<String?> _getLastPositionFromSharedPrefs() async {
    final sf = await SharedPreferences.getInstance();
    return sf.getString("position");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _getLastPositionFromSharedPrefs(),
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<RealtimeWeatherBloc>(
                create: (context) =>
                    sl()..add(FetchRealtimeWeatherEvent(snapshot.data)),
              ),
              BlocProvider<DevicePositionBloc>(
                create: (context) => sl(),
              ),
            ],
            child: ScreenUtilInit(
              designSize: const Size(393, 851), // PIXEL 5
              child: MaterialApp(
                theme: ThemeData(
                  colorScheme:
                      ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                  useMaterial3: true,
                ),
                debugShowCheckedModeBanner: false,
                home: const CustomPageView(),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return const CustomPageView();
  }
}

class CustomPageView extends StatelessWidget {
  const CustomPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          // forceMaterialTransparency: true,
          elevation: 0,
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
          title: const Text('weather'),
          actions: [
            BlocListener<DevicePositionBloc, DevicePoditionState>(
              listener: (context, state) {
                if (state is DevicePositionDone) {
                  BlocProvider.of<RealtimeWeatherBloc>(context).add(
                      FetchRealtimeWeatherEvent(state.position.toString()));
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
              child: BlocBuilder<DevicePositionBloc, DevicePoditionState>(
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
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        body: PageView(
          padEnds: false,
          controller: controller,
          children: const <Widget>[
            RealtimeWeather(),
            Center(
              child: Text('Second Page'),
            ),
            Center(
              child: Text('Third Page'),
            ),
          ],
        ));
  }
}
