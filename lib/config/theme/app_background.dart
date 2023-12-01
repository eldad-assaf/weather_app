import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BackGround extends StatefulWidget {
  final String isDay; // keep it a string
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
      print(start);
      if (start > 7.5) {
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
      child: Column(
        children: [
          Align(
            alignment: AlignmentDirectional(start, end),
            child: Container(
              height: 300.sp,
              width: 300.sp,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.isDay == '1' ? Colors.orange : Colors.blueGrey),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(start, end),
            child: Container(
              height: 300.sp,
              width: 300.sp,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.blue),
            ),
          ),
          Align(
            alignment: const AlignmentDirectional(0, -1.2),
            child: Container(
              height: 300.sp,
              width: 350.sp,
              decoration: const BoxDecoration(color: Colors.blue),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
            child: Container(
              decoration: const BoxDecoration(color: Colors.transparent),
            ),
          )
        ],
      ),
    );
  }
}

Widget buildAppBackground() {
  return SingleChildScrollView(
    child: Column(
      children: [
        Align(
          alignment: const AlignmentDirectional(3, -0.3),
          child: Container(
            height: 300.sp,
            width: 300.sp,
            decoration:
                const BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
          ),
        ),
        Align(
          alignment: const AlignmentDirectional(-3, -0.3),
          child: Container(
            height: 300.sp,
            width: 300.sp,
            decoration:
                const BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
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
            decoration: const BoxDecoration(color: Colors.transparent),
          ),
        )
      ],
    ),
  );
}
