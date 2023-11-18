import 'package:flutter/material.dart';
import 'package:weather_app/components/text_style.dart';

import '../../../../../components/reuseable_text.dart';

class RealtimeWeather extends StatelessWidget {
  const RealtimeWeather({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ReusableText(
          style: appStyle(
            50,
            Colors.black,
            FontWeight.bold,
          ),
          text: 'Tel-Aviv',
        )
      ],
    );
  }
}
