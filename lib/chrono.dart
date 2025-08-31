import 'dart:developer';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import 'package:hiitimer/digital_timer.dart';
import 'package:hiitimer/rounds_counter.dart';
import 'package:hiitimer/theme.dart';
import 'package:hiitimer/workout_config.dart';
import 'package:hiitimer/chronot_button.dart';

class ChronoInPause extends StatelessWidget {
  const ChronoInPause({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
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

class ChronoHeader extends StatelessWidget {
  const ChronoHeader({super.key, required this.timerName});

  final String timerName;

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
                  alignment: Alignment.centerLeft,
                  child: Text(
                    timerName,
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
              ChronoInPause(),
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
