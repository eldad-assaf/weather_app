import 'package:flutter/material.dart';


//**Deprecated */
// String setErrorMsg(RealtimeWeatherError? realtimeWeatherError) {
//   String errMsg = 'Something went wrong, try again later';
//   if (realtimeWeatherError != null) {
//     if (realtimeWeatherError.error != null &&
//         realtimeWeatherError.error!.response != null) {
//       errMsg = realtimeWeatherError.error!.response!.data['error']['message'];
//     } else {
//       return errMsg;
//     }
//   }

//   return errMsg;
// }

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

String handleWeatherApiErrors(int? httpStatusCode) {
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

String handleChatGPTApiErrors(int? httpStatusCode) {
  String errMsg;

  switch (httpStatusCode) {
    case 1002:
      errMsg = "API key not provided.";
      break;
    case 1003:
      errMsg = "Parameter not provided.";
      break;
    case 1005:
      errMsg = "API request URL is invalid.";
      break;
    case 1006:
      errMsg = "No location found matching parameter.";
      break;
    case 2006:
      errMsg = "API key provided is invalid.";
      break;
    case 2007:
      errMsg = "API key has exceeded calls per month quota.";
      break;
    case 2008:
      errMsg = "API key has been disabled.";
      break;
    case 2009:
      errMsg =
          "API key does not have access to the resource. Please check pricing page for what is allowed in your API subscription plan.";
      break;
    case 9000:
      errMsg =
          "Json body passed in bulk request is invalid. Please make sure it is valid JSON with utf-8 encoding.";
      break;
    case 9001:
      errMsg =
          "Json body contains too many locations for bulk request. Please keep it below 50 in a single request.";
      break;
    case 9999:
      errMsg = "Internal application error.";
      break;
    default:
      errMsg = "Unhandled API error with code $httpStatusCode";
  }
  return errMsg;
}
