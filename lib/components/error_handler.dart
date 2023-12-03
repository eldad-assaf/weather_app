import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/components/alert_dialog_model.dart';
import 'package:weather_app/features/realtime_weather/presentation/bloc/realtime_weather_bloc.dart';
import 'package:weather_app/features/realtime_weather/presentation/bloc/realtime_weather_event.dart';
import 'package:weather_app/features/realtime_weather/presentation/bloc/realtime_weather_state.dart';

errorHandler(BuildContext context, RealtimeWeatherError state) {
  String errMsg = 'Something went wrong, try again later';

  if (state.error != null && state.error!.response != null) {
    errMsg = state.error!.response!.data['error']['message'];
  }

  AlertDialogModel(
      title: 'Opps!',
      //message: "${state.error!.message}",//The request returned an invalid status code of 400.
      //message: "${state.error!.error}", //null
      //message: "${state.error!.response!.statusMessage}", //bad request
      //message: "${state.error!.response!.statusCode}", //400
      //message: "${state.error!.response!.data}", //{error: {code: 1006, message: No matching location found.}}
      message: errMsg,
      buttons: const {'OK': true}).present(context).then((value) {
    BlocProvider.of<RealtimeWeatherBloc>(context)
        .add(const FetchRealtimeWeatherEvent(null));
  });
}
