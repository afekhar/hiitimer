import 'dart:developer';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import 'package:hiitimer/digital_timer.dart';
import 'package:hiitimer/rounds_counter.dart';
import 'package:hiitimer/theme.dart';
import 'package:hiitimer/workout_config.dart';

class ChronoHeader extends StatelessWidget {
  const ChronoHeader({super.key, required this.timerName});

  final String timerName;

  @override
  Widget build(BuildContext context) {
    log("---> ChronoHeader.build(...)");
    return Container(
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown, // réduit la taille si nécessaire
                    // alignment: Alignment.bottomLeft, // ou center, right, etc.
                    child: Text(
                      timerName,
                      style: TextStyle(
                        fontSize: 100,
                        fontFamily: "SofiaSansExtraCondensed",
                        fontWeight: FontWeight.w900,
                        color: primary200,
                        background: Paint()..color = Colors.blue,
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Color(0xFF0000FF),
                  height: 30,
                  width: 100,
                )
              ],
            ),
          ),
          Container(
            color: Colors.deepPurple,
            width: 500,
            height: 200,
          )
        ],
      ),
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
