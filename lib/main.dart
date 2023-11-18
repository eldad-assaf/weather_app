import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/features/realtime_weather/domain/usecases/fetch_realtime_weather.dart';
import 'package:weather_app/injection_container.dart';

import 'features/realtime_weather/presentation/pages/home/realtime_weather.dart';

void main() async {
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(393, 851), // PIXEL 5
        child: MaterialApp(
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          home: Home(sl()),
        ));
  }
}

class Home extends StatefulWidget {
  final FetchRealtimeWeatherUseCase _fetchRealtimeWeatherUseCase;
  const Home(this._fetchRealtimeWeatherUseCase, {super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('weather'),
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
