import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_app/components/text_style.dart';
import 'package:weather_app/features/realtime_weather/presentation/bloc/realtime_weather_bloc.dart';

import '../../../../../components/reuseable_text.dart';
import '../../bloc/realtime_weather_state.dart';

class RealtimeWeather extends StatelessWidget {
  const RealtimeWeather({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RealtimeWeatherBloc, RealtimeWeatherState>(
      builder: (context, state) {
        
        if (state is RealtimeWeatherLoading ||
            state is RealtimeWeatherInitial) {
          return Container();
        }
        return Container(
          color: Colors.white,
          child: Column(
            children: [
              ReusableText(
                style: appStyle(
                  50,
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
                text: "Today",
              ),
              SizedBox(
                height: 50.sp,
              ),
              ReusableText(
                style: appStyle(
                  70,
                  Colors.black,
                  FontWeight.bold,
                ),
                text: "${state.realtimeWeather?.tempC}C",
              ),
              SizedBox(
                  width: ScreenUtil().setWidth(222),
                  child: const Divider(
                    thickness: 3,
                  )),
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
                height: 22.sp,
              ),
              FaIcon(
                FontAwesomeIcons.cloudSun,
                size: 85.sp,
              )
            ],
          ),
        );
      },
    );
  }
}
