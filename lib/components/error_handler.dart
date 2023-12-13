import 'package:flutter/material.dart';
import 'package:weather_app/components/alert_dialog_model.dart';
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
      .present(context);
}
