import 'package:flutter/material.dart';
import 'package:weather_app/features/realtime_weather/presentation/bloc/realtime_weather_state.dart';

String setErrorMsg(RealtimeWeatherError? realtimeWeatherError) {
  String errMsg = 'Something went wrong, try again later';
  if (realtimeWeatherError != null) {
    if (realtimeWeatherError.error != null &&
        realtimeWeatherError.error!.response != null) {
      errMsg = realtimeWeatherError.error!.response!.data['error']['message'];
    } else {
      return errMsg;
    }
  }

  return errMsg;
}

Widget getWeatherIcon(int code) {
  switch (code) {
    case == 1000: //suuny
      return Image.asset('assets/6.png');
    case == 1003: // partly cloudy
      return Image.asset('assets/7.png');
    case >= 1006: // cloudy
      return Image.asset('assets/8.png');
    case >= 1009: // overcast
      return Image.asset('assets/8.png');
    case >= 1030: //mist
      return Image.asset('assets/5.png');
    case == 1063: // Patchy rain possible
      return Image.asset('assets/2.png');
    case == 1066: //Patchy snow possible
      return Image.asset('assets/4.png');
    case == 1069: //Patchy snow possible
      return Image.asset('assets/4.png');
    case == 1072: //Patchy freezing drizzle possible
      return Image.asset('assets/4.png');
    case == 1087: //Thundery outbreaks possible
      return Image.asset('assets/1.png');
    case == 1087: //Thundery outbreaks possible
      return Image.asset('assets/1.png');

    default:
      return Image.asset(
        'assets/14.png',
      );
  }
}

String handleHttpStatus(int? httpStatusCode) {
  String errMsg;
  switch (httpStatusCode) {
    case null:
      errMsg = 'Unknown Error!';
    case 401:
      errMsg = '"Unauthorized: API key not provided or invalid."';

      break;
    case 400:
      errMsg = "Bad Request: Check the request parameters.";
      break;
    case 403:
      errMsg = "Forbidden: API key issues or access denied.";
      break;
    default:
      errMsg = "Unhandled HTTP Status Code: $httpStatusCode";
  }
  return errMsg;
}
