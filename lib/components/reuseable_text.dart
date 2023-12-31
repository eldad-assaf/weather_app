import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ReusableText extends StatelessWidget {
  final String text;
  final TextStyle style;
  const ReusableText({super.key, required this.text, required this.style});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      textAlign: TextAlign.left,
      softWrap: false,
      overflow: TextOverflow.fade,
      style: style,
    );
  }
}

class ReusableTextWithAutoSize extends StatelessWidget {
  final String text;
  final int? maxLines;
  final double minFontSize;
  final TextStyle style;
  const ReusableTextWithAutoSize(
      {super.key,
      required this.text,
      required this.maxLines,
      required this.minFontSize,
      required this.style});

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      minFontSize: minFontSize,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: style,
    );
  }
}
