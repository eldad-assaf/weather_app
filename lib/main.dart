import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/components/alert_dialog_model.dart';
import 'package:weather_app/components/error_handler.dart';
import 'package:weather_app/components/reuseable_text.dart';
import 'package:weather_app/components/text_style.dart';
import 'package:weather_app/features/chat_gpt_weather/data/repositories/open_ai_repository_impl.dart';
import 'package:weather_app/features/chat_gpt_weather/domain/repositories/open_ai_repository.dart';
import 'package:weather_app/features/device_position/presentation/bloc/device_position_bloc.dart';
import 'package:weather_app/features/map_view/presentation/bloc/camera_position_bloc.dart';
import 'package:weather_app/features/map_view/presentation/pages/home/map_view.dart';
import 'package:weather_app/features/realtime_weather/domain/entities/realtime_weather.dart';
import 'package:weather_app/features/realtime_weather/presentation/bloc/realtime_weather_event.dart';
import 'package:weather_app/features/realtime_weather/presentation/bloc/realtime_weather_state.dart';
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
    return BlocBuilder<RealtimeWeatherBloc, RealtimeWeatherState>(
      builder: (context, state) {
        if (state is RealtimeWeatherInitial ||
            state is RealtimeWeatherLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (state is RealtimeWeatherError) {
          return const Scaffold(
            body: Center(
                child: Text(
                    'Opps, something went wrong with the weather service,\n please try again later')),
          );
        }
        if (state is RealtimeWeatherDone) {
          return SafeArea(
            child: Scaffold(
              extendBodyBehindAppBar: true,
              backgroundColor: state.realtimeWeather!.isDay == 1
                  ? Colors.blue
                  : Colors.black,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                // forceMaterialTransparency: true,
                elevation: 3,
                systemOverlayStyle: const SystemUiOverlayStyle(
                    statusBarBrightness: Brightness.dark),
                title: ReusableText(
                    text: 'Weather',
                    style: appStyle(18, Colors.white, FontWeight.w300)),
                actions: [
                  IconButton(
                      color: Colors.red,
                      onPressed: () async {
                        SharedPreferences sf =
                            await SharedPreferences.getInstance();
                        await sf.clear();
                      },
                      icon: const Icon(Icons.delete)),
                  BlocListener<DevicePositionBloc, DevicePositionState>(
                    listener: (context, state) {
                      if (state is DevicePositionDone) {
                        BlocProvider.of<RealtimeWeatherBloc>(context).add(
                            FetchRealtimeWeatherEvent(
                                state.position!.asString()));
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
              body: PageView(
                padEnds: false,
                controller: controller,
                children: const <Widget>[
                  RealtimeWeather(),
                  //  MapView(),
                  GptWeather(),
                ],
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class GptWeather extends StatefulWidget {
  const GptWeather({super.key});

  @override
  State<GptWeather> createState() => _GptWeatherState();
}

class _GptWeatherState extends State<GptWeather> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<RealtimeWeatherBloc, RealtimeWeatherState>(
        builder: (context, state) {
          if (state is RealtimeWeatherInitial ||
              state is RealtimeWeatherLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is RealtimeWeatherError) {
            errorHandler(context, state);
          }
          if (state is RealtimeWeatherDone) {
            return SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 13.sp,
                    ),
                    Center(
                      child: ReusableText(
                          text: 'AI Suggestions',
                          style: appStyle(33, Colors.white, FontWeight.bold)),
                    ),
                    SizedBox(
                      height: 20.sp,
                    ),
                    ReusableTextWithAutoSize(
                      text:
                          'Use our AI system to see a short `Human` explantion on the weather in :',
                      maxLines: 20,
                      minFontSize: 11,
                      style: appStyle(
                        18,
                        Colors.white,
                        FontWeight.normal,
                      ),
                    ),
                    SizedBox(
                      height: 5.sp,
                    ),
                    ReusableText(
                        text: state.realtimeWeather!.loactionName ??
                            'your location',
                        style: appStyle(25, Colors.white, FontWeight.bold)),
                    ReusableTextWithAutoSize(
                      text: 'use the location icon or the map to change place.',
                      maxLines: 2,
                      minFontSize: 11,
                      style: appStyle(
                        15,
                        Colors.white,
                        FontWeight.normal,
                      ),
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    TextButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.red),
                        ),
                        onPressed: () {

                          //helper method to construct the messageContent
                          sl<OpenAIRepository>()
                              .getWeatherExplanationFromChatGpt(
                                  messageContent: 'messageContent');
                        },
                        child: ReusableText(
                          style: appStyle(33, Colors.white, FontWeight.bold),
                          text: 'Try me!',
                        )),
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
