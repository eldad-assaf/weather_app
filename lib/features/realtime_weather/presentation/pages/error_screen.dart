import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/components/reuseable_text.dart';
import 'package:weather_app/components/text_style.dart';
import 'package:weather_app/core/helpers/helpers_methods.dart';

class ErrorScreen extends StatelessWidget {
  final DioException? dioException;
  const ErrorScreen({
    required this.dioException,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final errMsg = handleHttpStatus(dioException?.response?.statusCode);
    final errMsg = handleHttpStatus(null);

    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.red,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          // forceMaterialTransparency: true,
          elevation: 3,
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 5, left: 5),
            child: ReusableTextWithAutoSize(
                text:
                    'Please Talk with me to get an api key or get your own one from https://www.weatherapi.com/ \n \n The error code is  ${dioException?.response?.statusCode} \n the error msg is : $errMsg',
                maxLines: 8,
                minFontSize: 15,
                style: appStyle(15, Colors.white, FontWeight.bold)),
          ),
          // child: Text('Please Talk with me to get an api key!  ')),
        ));
  }
}
