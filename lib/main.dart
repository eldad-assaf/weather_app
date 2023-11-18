import 'package:flutter/material.dart';
import 'package:weather_app/features/realtime_weather/domain/usecases/fetch_realtime_weather.dart';
import 'package:weather_app/injection_container.dart';

void main() async {
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Home(sl()),
    );
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
  void initState() {
    //try fatch here for test :
    Future.delayed(Duration.zero, () async {
      final data = await widget._fetchRealtimeWeatherUseCase.call();
      print(data.data!.conditionCode.toString());
      print(data.data!.tempC.toString());
      print(data.data!.loactionName.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
