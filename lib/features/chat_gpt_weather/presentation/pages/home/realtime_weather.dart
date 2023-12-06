import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/components/text_style.dart';
import 'package:weather_app/features/chat_gpt_weather/domain/repositories/open_ai_repository.dart';
import 'package:weather_app/features/realtime_weather/presentation/bloc/realtime_weather_bloc.dart';
import 'package:weather_app/injection_container.dart';
import '../../../../../components/error_handler.dart';
import '../../../../../components/reuseable_text.dart';
import '../../../../realtime_weather/presentation/bloc/realtime_weather_state.dart';

class WeatherAI extends StatefulWidget {
  const WeatherAI({super.key});

  @override
  State<WeatherAI> createState() => _WeatherAIState();
}

class _WeatherAIState extends State<WeatherAI> {
  String? chatResponse;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<RealtimeWeatherBloc, RealtimeWeatherState>(
        builder: (context, state) {
          if (state is RealtimeWeatherInitial ||
              state is RealtimeWeatherLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is RealtimeWeatherError) {
            errorHandler(context, state);
          }
          if (state is RealtimeWeatherDone) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 13.sp,
                  ),
                  Center(
                    child: ReusableText(
                        text: 'AI Suggestions',
                        style: appStyle(33, Colors.white, FontWeight.bold)),
                  ),
                  SizedBox(
                    height: 20.sp,
                  ),
                  ReusableTextWithAutoSize(
                    text:
                        'Check out the latest weather update for ${state.realtimeWeather!.loactionName} with our AI system!',
                    maxLines: 4,
                    minFontSize: 15,
                    style: appStyle(
                      18,
                      Colors.white,
                      FontWeight.normal,
                    ),
                  ),
                  SizedBox(
                    height: 5.sp,
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  Center(
                    child: TextButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.red),
                        ),
                        onPressed: () async {
                          final question = sl<OpenAIRepository>()
                              .buildQuestionForChatGpt(
                                  realtimeWeatherEntity:
                                      state.realtimeWeather!);

                          chatResponse = await sl<OpenAIRepository>()
                              .getWeatherExplanationFromChatGpt(
                                  messageContent: question);
                          if (chatResponse != null) {
                            setState(() {});
                          }
                        },
                        child: ReusableText(
                          style: appStyle(33, Colors.white, FontWeight.bold),
                          text: 'Try me!',
                        )),
                  ),
                  chatResponse != null
                      ? ReusableTextWithAutoSize(
                          text: chatResponse!,
                          maxLines: 20,
                          minFontSize: 15,
                          style: appStyle(15, Colors.white, FontWeight.w500))
                      : Container(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ReusableTextWithAutoSize(
                      text: 'use the location icon or the map to change place.',
                      maxLines: 1,
                      minFontSize: 11,
                      style: appStyle(
                        15,
                        Colors.white,
                        FontWeight.normal,
                      ),
                    ),
                  )
                ],
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
