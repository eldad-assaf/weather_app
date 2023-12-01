import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BackGround extends StatefulWidget {
  final int isDay;
  const BackGround({super.key, required this.isDay});

  @override
  State<BackGround> createState() => _BackGroundState();
}

class _BackGroundState extends State<BackGround> {
  double start = 0;
  double end = 0;
  @override
  void initState() {
    Timer.periodic(const Duration(milliseconds: 20), (timer) {
      if (start> 7.5) {
        start = -7.5;
        end = -7.5;
      }
      start = start + 0.02;
      end = end + 0.02;
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          Align(
            alignment: AlignmentDirectional(start, end),
            child: Container(
              height: 300.sp,
              width: 300.sp,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.isDay == 1 ? Colors.orange : Colors.blueGrey),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
            child: Container(
              decoration: const BoxDecoration(color: Colors.transparent),
            ),
          )
        ],
      ),
    );
  }
}

