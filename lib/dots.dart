import 'package:flutter/material.dart';

class DigitalTimerDots extends StatefulWidget {
  const DigitalTimerDots(
      {super.key, required this.color, required this.displayRatio});

  final String color;
  final double displayRatio;

  static int width = 86;
  static int height = 400;

  @override
  State<DigitalTimerDots> createState() => _DigitalTimerDotsState();
}

class _DigitalTimerDotsState extends State<DigitalTimerDots> {
  @override
  void didChangeDependencies() {
    precacheImage(
        AssetImage('assets/images/digits/${widget.color}/dots.png'), context);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/digits/${widget.color}/dots.png',
      width: DigitalTimerDots.width * widget.displayRatio,
      height: DigitalTimerDots.height * widget.displayRatio,
    );
  }
}
