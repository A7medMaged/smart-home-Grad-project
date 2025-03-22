import 'package:flutter/material.dart';
import 'package:smart_home_app/core/theming/colors.dart';

// ignore: must_be_immutable
class CSnackBar extends StatelessWidget {
  String? content;
  Duration? duration;
  Color? backgroundColor;
  CSnackBar(
      {super.key,
      required content,
      required Duration duration,
      required Color backgroundColor});

  @override
  Widget build(BuildContext context) {
    return CSnackBar(
      content: Text(
        content!,
        style: const TextStyle(color: white),
      ),
      duration: duration!,
      backgroundColor: backgroundColor!,
    );
  }
}
