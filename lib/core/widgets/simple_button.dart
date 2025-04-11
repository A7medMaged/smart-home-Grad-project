import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';

class MyCustomWidget extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _MyCustomWidgetState createState() => _MyCustomWidgetState();
  final String? title;
  final void Function() onPressed;
  const MyCustomWidget({
    super.key,
    this.title,
    required this.onPressed,
  });
}

class _MyCustomWidgetState extends State<MyCustomWidget> {
  @override
  Widget build(BuildContext context) {
    return AnimatedButton(
      color: Colors.blue,
      onPressed: widget.onPressed,
      enabled: true,
      shadowDegree: ShadowDegree.light,
      child: Text(
        widget.title!,
        style: TextStyle(
          fontSize: 22,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
