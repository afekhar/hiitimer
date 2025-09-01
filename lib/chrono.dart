import 'dart:developer';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import 'package:hiitimer/digital_timer.dart';
import 'package:hiitimer/rounds_counter.dart';
import 'package:hiitimer/theme.dart';
import 'package:hiitimer/workout_config.dart';
import 'package:hiitimer/chrono_button.dart';

class ChronoInPause extends StatefulWidget {
  const ChronoInPause({super.key});

  @override
  State<ChronoInPause> createState() => _ChronoInPauseState();
}

class _ChronoInPauseState extends State<ChronoInPause>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true); // repeat from 0 to 1 then from 1 to 0

    _animation = Tween<double>(begin: 1.0, end: 0.0).animate(_controller);
  }

  @override
  void dispose() {
    log("---> ChronoInPause.dispose()");
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: IntrinsicWidth(
        child: Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 17), // espace horizontal
          decoration: BoxDecoration(
            color: Color(0xFF0000FF), // bleu
            borderRadius:
                BorderRadius.circular(12), // coins arrondis (~0.25 de la taille)
          ),
          height: 30,
          child: Align(
              alignment: Alignment.center,
              child: Text(
                'en pause',
                style: TextStyle(
                    fontFamily: 'BalooTamma2',
                    fontWeight: FontWeight.w900,
                    fontSize: 15.0,
                    color: primary50),
              )),
        ),
      ),
    );
  }
}

class ChronoButtonsBar extends StatefulWidget {
  const ChronoButtonsBar({super.key});

  @override
  State<ChronoButtonsBar> createState() => _ChronoButtonsBarState();
}

class _ChronoButtonsBarState extends State<ChronoButtonsBar> {
  @override
  void didChangeDependencies() {
    final List<String> buttons = ['stop', 'play', 'pause', 'pause', 'replay'];

    for (final button in buttons) {
      precacheImage(
          AssetImage('assets/images/buttons/chrono_$button.png'), context);
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ChronotButton(type: 'stop'),
        ChronotButton(type: 'play'),
        ChronotButton(type: 'close'),
      ],
    );
  }
}

class ChronoHeader extends StatefulWidget {
  const ChronoHeader({super.key, required this.timerName});

  final String timerName;

  @override
  State<ChronoHeader> createState() => _ChronoHeaderState();
}

class _ChronoHeaderState extends State<ChronoHeader> {
  final bool _inPauseMode = false;

  @override
  Widget build(BuildContext context) {
    log("---> ChronoHeader.build(...)");
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: FittedBox(
                  fit: BoxFit.scaleDown, // réduit la taille si nécessaire
                  alignment: _inPauseMode
                      ? Alignment.bottomLeft
                      : Alignment.centerLeft,
                  child: Text(
                    widget.timerName,
                    style: TextStyle(
                      fontSize: 75,
                      fontFamily: "SofiaSansExtraCondensed",
                      fontWeight: FontWeight.w900,
                      color: primary300,
                      // background: Paint()..color = Colors.blue,
                    ),
                  ),
                ),
              ),
              _inPauseMode ? ChronoInPause() : SizedBox.shrink(),
            ],
          ),
        ),
        SizedBox(
          width: 100,
        ),
        ChronoButtonsBar(),
      ],
    );
  }
}

class ChronoBody extends StatelessWidget {
  const ChronoBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end, // align widgets to bottom
      children: [
        Expanded(
          flex: 12,
          child: RoundsCounter(round: 3),
        ),
        Expanded(flex: 3, child: Container()),
        Expanded(
          flex: 40,
          child: DigitalTimer(targetInSeconds: 10),
        ),
      ],
    );
  }
}

class Chrono extends StatelessWidget {
  const Chrono({super.key, required this.workoutConfig});

  final WorkoutConfig workoutConfig;

  @override
  Widget build(BuildContext context) {
    log("---> Chrono.build(...)");

    return Scaffold(
      backgroundColor: primary950,
      body: SafeArea(
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ChronoHeader(
                  timerName: workoutConfig.name,
                ),
              ),
              // Expanded(
              //   child: Row(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       FittedBox(
              //           fit: BoxFit.scaleDown, // réduit la taille si nécessaire
              //           alignment: Alignment.centerLeft, // ou center, right, etc.
              //           child: Text(
              //       widget.workoutConfig.name,
              //             style: TextStyle(
              //               fontSize: 100,
              //               fontFamily: "SofiaSansExtraCondensed",
              //               fontWeight: FontWeight.w900,
              //               color: primary200,
              //             ), // taille max
              //           ),
              //         ),
              //     ],
              //   ),
              // ),
              // Expanded(child: Container()),
              ChronoBody(),
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.pop(context);
              //   },
              //   child: const Text("Back to Home"),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
