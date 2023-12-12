import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/components/alert_dialog_model.dart';
import 'package:weather_app/features/realtime_weather/presentation/bloc/realtime_weather_bloc.dart';
import 'package:weather_app/features/realtime_weather/presentation/bloc/realtime_weather_event.dart';
import 'package:weather_app/features/realtime_weather/presentation/bloc/realtime_weather_state.dart';

errorHandler(
    BuildContext context, RealtimeWeatherError? state, Exception? openAIError) {
  //This error handler is for both errors that comes from the RealtimeWeatherBloc, try/catch block and openAIAuthError
  //in the cases from the try/catch blocks a scaffold key is required ! it is  using the context in async operation.
  String errMsg = 'Something went wrong, try again later';

  if (state != null) {
    //**Handle the error from the RealtimeWeatherBloc  */
    if (state.error != null && state.error!.response != null) {
      errMsg = state.error!.response!.data['error']['message'];
    }
  }

  if (openAIError != null) {
    errMsg =
        'Something went wrong with the AI service, please check with the app admin';
  }

  AlertDialogModel(title: 'Opps!', message: errMsg, buttons: const {'OK': true})
      .present(context)
      .then((value) {
    //TODO: set back the state to initial

    if (state != null) {
      //**If the error is coming from the RealtimeWeatherBloc then it will change the state back to Initial state  */
      BlocProvider.of<RealtimeWeatherBloc>(context)
          .add(const FetchRealtimeWeatherEvent(null));
    }
    // BlocProvider.of<RealtimeWeatherBloc>(context)
    //     .add(const FetchRealtimeWeatherEvent(null));
  });
}
