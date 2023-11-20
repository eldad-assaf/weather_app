import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RealtimeWeatherBloc>(
          create: (context) => sl()..add(const FetchRealtimeWeatherEvent(null)),
        ),
        BlocProvider<DeviceLocationBloc>(
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

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('weather'),
        actions: [
          BlocListener<DeviceLocationBloc, DeviceLocationState>(
            listener: (context, state) {
              print('new state : ${state.toString()}');
              if (state is DeviceCityNameDone) {
                BlocProvider.of<RealtimeWeatherBloc>(context)
                    .add(FetchRealtimeWeatherEvent(state.cityName));
              }
            },
            child: BlocBuilder<DeviceLocationBloc, DeviceLocationState>(
              builder: (context, state) {
                return InkWell(
                  onTap: () {
                    BlocProvider.of<DeviceLocationBloc>(context)
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
          )
        ],
      ),
      body: const SafeArea(child: CustomPageView()),
    );
  }
}

class CustomPageView extends StatelessWidget {
  const CustomPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    return PageView(
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
    );
  }
}
