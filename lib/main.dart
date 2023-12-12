// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/components/app_bar_widget.dart';
import 'package:weather_app/components/error_handler.dart';
import 'package:weather_app/features/chat_gpt_weather/presentation/pages/home/weather_ai.dart';
import 'package:weather_app/features/device_position/presentation/bloc/device_position_bloc.dart';
import 'package:weather_app/features/map_view/presentation/bloc/camera_position_bloc.dart';
import 'package:weather_app/features/realtime_weather/presentation/bloc/realtime_weather_event.dart';
import 'package:weather_app/features/realtime_weather/presentation/bloc/realtime_weather_state.dart';
import 'package:weather_app/features/realtime_weather/presentation/pages/error_screen.dart';
import 'package:weather_app/injection_container.dart';
import 'features/realtime_weather/presentation/bloc/realtime_weather_bloc.dart';
import 'features/realtime_weather/presentation/pages/home/realtime_weather.dart';

void main() async {
  //**The .env file is in gitignore , you will have to create your own openAI key. */
  //**ONCE THE KEY IS UPLOADED TO GIT IT IS BLOCKED AUTOMATICALLY  */
  await dotenv.load(
      fileName: ".env"); // must load this before initializeDependencies()
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
        //**When app starts the weather is fetched without the device's position*/
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
        //**Design size for Pixel 5 device */
        designSize: const Size(393, 851),
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

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<_HomeState> key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    return BlocConsumer<RealtimeWeatherBloc, RealtimeWeatherState>(
      listener: (context, state) {
        if (state is RealtimeWeatherError) {
          errorHandler(context, state, null);
        }
      },
      builder: (context, state) {
        if (state is RealtimeWeatherInitial) {
          return const Center();
        }
        if (state is RealtimeWeatherLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is RealtimeWeatherDone) {
          return SafeArea(
            child: Scaffold(
              key: key,
              extendBodyBehindAppBar: true,
              backgroundColor: state.realtimeWeather!.isDay == 1
                  ? Colors.blue
                  : Colors.black,
              appBar: const AppBarWidget(),
              body: PageView(
                padEnds: false,
                controller: controller,
                children: <Widget>[
                  const RealtimeWeather(),
                  WeatherAI(scaffoldKey: key),
                ],
              ),
            ),
          );
        } else {
          print(state.error);
          return ErrorScreen(dioException: state.error!);
        }
      },
    );
  }
}
