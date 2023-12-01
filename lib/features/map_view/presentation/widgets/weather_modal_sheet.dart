import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_app/components/text_style.dart';
import 'package:weather_app/features/realtime_weather/domain/entities/realtime_weather.dart';

import '../../../../components/reuseable_text.dart';

class WeatherModalSheet extends StatelessWidget {
  final RealtimeWeatherEntity realtimeWeather;
  const WeatherModalSheet({super.key, required this.realtimeWeather});

  @override
  Widget build(BuildContext context) {
    final locationName = realtimeWeather.loactionName;
    final localTime = realtimeWeather.localTime;
    final lastUpdated = realtimeWeather.lastUpdated;
    final windMph = realtimeWeather.windMph;
    final windKph = realtimeWeather.windKph;
    final cloud = realtimeWeather.cloud;
    final uv = realtimeWeather.uv;
    final isDay = realtimeWeather.isDay;

    return Container(
      color: Colors.green,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text('data'),
            ),
            ReusableText(
                text: locationName!,
                style: appStyle(25, Colors.white, FontWeight.w300)),
            // Text(localTime!),
            // Text(lastUpdated!),
            ReusableText(
                text: 'Local time : ${localTime!}',
                style: appStyle(18, Colors.white, FontWeight.w300)),
            ReusableText(
                text: 'Last Updated : $lastUpdated',
                style: appStyle(18, Colors.white, FontWeight.w300)),
            SizedBox(
              height: 35.sp,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    FaIcon(
                      Icons.wind_power,
                      size: 65.sp,
                    ),
                    ReusableText(
                        text: '${windMph.toString()} MPH',
                        style: appStyle(22, Colors.white, FontWeight.bold)),
                    ReusableText(
                        text: '${windKph.toString()} KPH',
                        style: appStyle(22, Colors.white, FontWeight.bold)),
                  ],
                ),
                Column(
                  children: [
                    FaIcon(
                      Icons.cloud,
                      size: 65.sp,
                    ),
                    ReusableText(
                        text: 'Clouds $cloud',
                        style: appStyle(22, Colors.white, FontWeight.bold)),
                    ReusableText(
                        text: '', // Just to align the wind and clouds icons
                        style: appStyle(22, Colors.white, FontWeight.bold))
                  ],
                )
              ],
            ),
            SizedBox(
              height: 35.sp,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Stack(
                      children: [
                        Positioned(
                          child: FaIcon(
                            Icons.face,
                            size: 65.sp,
                          ),
                        ),
                        Positioned(
                          left: 39,
                          child: FaIcon(
                            Icons.sunny,
                            color: Colors.amber,
                            size: 35.sp,
                          ),
                        ),
                      ],
                    ),

                    // FaIcon(
                    //   Icons.face,
                    //   size: 65.sp,
                    // ),
                    ReusableText(
                        text: 'UV $uv',
                        style: appStyle(22, Colors.white, FontWeight.bold))
                  ],
                ),
                Column(
                  children: [
                    FaIcon(
                      isDay == 1 ? Icons.mode_night : Icons.light_mode_outlined,
                      size: 65.sp,
                    ),
                    ReusableText(
                        text: isDay == 1 ? 'Night' : 'Day',
                        style: appStyle(22, Colors.white, FontWeight.bold))
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
