import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/components/error_handler.dart';
import 'package:weather_app/components/text_style.dart';
import 'package:weather_app/config/theme/app_background.dart';
import 'package:weather_app/features/realtime_weather/presentation/bloc/realtime_weather_bloc.dart';

import '../../../../../components/reuseable_text.dart';
import '../../bloc/realtime_weather_state.dart';

class RealtimeWeather extends StatelessWidget {
  const RealtimeWeather({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RealtimeWeatherBloc, RealtimeWeatherState>(
      listener: (context, state) {
        if (state is RealtimeWeatherError) {
          errorHandler(context, state);
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
                    //  buildAppBackground(),
                    BackGround(
                      isDay: state.realtimeWeather!.isDay!,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(top: 30.sp),
                        child: Column(
                          children: [
                            ReusableText(
                              style: appStyle(
                                45,
                                Colors.white,
                                FontWeight.bold,
                              ),
                              text: state.realtimeWeather?.loactionName ?? '',
                            ),
                            ReusableText(
                              style: appStyle(
                                25,
                                Colors.white,
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
                            SizedBox(width: 222.sp, child: const Divider()),
                            SizedBox(
                              height: 50.sp,
                            ),
                            ReusableTextWithAutoSize(
                              maxLines: 1,
                              minFontSize: 15,
                              style: appStyle(
                                30,
                                Colors.white,
                                FontWeight.normal,
                              ),
                              text: state.realtimeWeather?.conditionText ?? '',
                            ),
                            SizedBox(
                              height: 20.sp,
                            ),
                            SizedBox(
                                width: 100.sp,
                                height: 100.sp,
                                child: getWeatherIcon(
                                    state.realtimeWeather!.conditionCode!)),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(bottom: 50.sp, right: 3, left: 1),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: ReusableTextWithAutoSize(
                          text: 'swipe to see AI recommendations ',
                          maxLines: 1,
                          minFontSize: 14,
                          style: appStyle(22, Colors.amber, FontWeight.bold),
                        ),
                      ),
                    )
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
}
