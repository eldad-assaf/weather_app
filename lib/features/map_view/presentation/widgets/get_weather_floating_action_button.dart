import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_app/features/device_position/presentation/bloc/device_position_bloc.dart';
import 'package:weather_app/features/map_view/presentation/widgets/weather_modal_sheet.dart';
import 'package:weather_app/features/realtime_weather/presentation/bloc/realtime_weather_bloc.dart';
import 'package:weather_app/features/realtime_weather/presentation/bloc/realtime_weather_event.dart';
import 'package:weather_app/features/realtime_weather/presentation/bloc/realtime_weather_state.dart';


class GetWeatherFloatingActionButton extends StatelessWidget {
  final LatLng middleOfTheMap;
  const GetWeatherFloatingActionButton(BuildContext context, {super.key , required this.middleOfTheMap});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () async {
        context
            .read<RealtimeWeatherBloc>()
            .add(FetchRealtimeWeatherEvent(middleOfTheMap.asString()));
        await showModalBottomSheet(
            useSafeArea: true,
            //barrierColor: Colors.blue,
            isScrollControlled: true,
            showDragHandle: true,
            context: context,
            builder: (context) {
              return BlocBuilder<RealtimeWeatherBloc, RealtimeWeatherState>(
                builder: (context, state) {
                  if (state is RealtimeWeatherLoading) {
                    return Container();
                  } else if (state is RealtimeWeatherDone) {
                    return WeatherModalSheet(
                      realtimeWeather: state.realtimeWeather!,
                    );
                  } else {
                    return Container(
                      height: 550.sp,
                      color: Colors.red,
                    );
                  }
                },
              );
            });
      },
      label: const Text('Get weather'),
      icon: const Icon(Icons.directions_boat),
    );
  }
}
