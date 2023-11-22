import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/components/alert_dialog_model.dart';
import 'package:weather_app/components/text_style.dart';
import 'package:weather_app/features/realtime_weather/presentation/bloc/realtime_weather_bloc.dart';
import 'package:weather_app/features/realtime_weather/presentation/bloc/realtime_weather_event.dart';

import '../../../../../components/reuseable_text.dart';
import '../../bloc/realtime_weather_state.dart';

class RealtimeWeather extends StatelessWidget {
  const RealtimeWeather({super.key});

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

  @override
  Widget build(BuildContext context) {
    return BlocListener<RealtimeWeatherBloc, RealtimeWeatherState>(
      listener: (context, state) {
        if (state is RealtimeWeatherError) {
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
      },
      child: BlocBuilder<RealtimeWeatherBloc, RealtimeWeatherState>(
        builder: (context, state) {
          if (state is RealtimeWeatherLoading ||
              state is RealtimeWeatherInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RealtimeWeatherDone) {
            return Padding(
              padding: const EdgeInsets.only(top: 1.8 * kToolbarHeight),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Align(
                      alignment: const AlignmentDirectional(3, -0.3),
                      child: Container(
                        height: 300.sp,
                        width: 300.sp,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.purple),
                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(-3, -0.3),
                      child: Container(
                        height: 300.sp,
                        width: 300.sp,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.purple),
                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(0, -1.2),
                      child: Container(
                        height: 300.sp,
                        width: 350.sp,
                        decoration: const BoxDecoration(color: Colors.orange),
                      ),
                    ),
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                      child: Container(
                        decoration:
                            const BoxDecoration(color: Colors.transparent),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          ReusableText(
                            style: appStyle(
                              25,
                              Colors.black,
                              FontWeight.bold,
                            ),
                            text: state.realtimeWeather?.loactionName ?? '',
                          ),
                          ReusableText(
                            style: appStyle(
                              25,
                              Colors.black,
                              FontWeight.w300,
                            ),
                            text: "Now",
                          ),
                          SizedBox(
                            height: 50.sp,
                          ),
                          ReusableText(
                            style: appStyle(
                              70,
                              Colors.white,
                              FontWeight.bold,
                            ),
                            text: "${state.realtimeWeather?.tempC}C",
                          ),
                          SizedBox(
                              width: ScreenUtil().setWidth(222),
                              child: const Divider()),
                          SizedBox(
                            height: 50.sp,
                          ),
                          ReusableText(
                            style: appStyle(
                              25,
                              Colors.black,
                              FontWeight.normal,
                            ),
                            text: state.realtimeWeather?.conditionText ?? '',
                          ),
                          SizedBox(
                              width: 180.sp,
                              height: 180.sp,
                              child: getWeatherIcon(
                                  state.realtimeWeather!.conditionCode!)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
