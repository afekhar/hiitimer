import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import 'package:hiitimer/digital_timer.dart';
import 'package:hiitimer/rounds_counter.dart';
import 'package:hiitimer/theme.dart';

class Chrono extends StatefulWidget {
  const Chrono({super.key});

  @override
  State<Chrono> createState() => _ChronoState();
}

class _ChronoState extends State<Chrono> {
  int _seconds = 0;

  @override
  void initState() {
    super.initState();
    WakelockPlus.enable();

    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if ((_seconds + 1) < 60) {
        setState(() {
          _seconds++;
        });
      } else {
        timer.cancel();
        WakelockPlus.disable();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary950,
      body: SafeArea(
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.end, // align widgets to bottom
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
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Back to Home"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
