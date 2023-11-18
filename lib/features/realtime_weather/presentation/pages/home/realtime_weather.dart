import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/components/text_style.dart';
import 'package:weather_app/features/realtime_weather/presentation/bloc/realtime_weather_bloc.dart';

import '../../../../../components/reuseable_text.dart';
import '../../bloc/realtime_weather_state.dart';

class RealtimeWeather extends StatelessWidget {
  const RealtimeWeather({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RealtimeWeatherBloc, RealtimeWeatherState>(
      builder: (context, state) {
        return Column(
          children: [
            ReusableText(
              style: appStyle(
                50,
                Colors.black,
                FontWeight.bold,
              ),
              text: state.realtimeWeather?.loactionName ?? '',
            )
          ],
        );
      },
    );
  }
}
