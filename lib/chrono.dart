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
            borderRadius: BorderRadius.circular(
                12), // coins arrondis (~0.25 de la taille)
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

enum Phase {
  initialCountdown,
  upWork,
  downRest,
}

class WorkoutTimerDisplay extends StatefulWidget {
  const WorkoutTimerDisplay({super.key, required this.config});

  final WorkoutConfig config;

  @override
  State<WorkoutTimerDisplay> createState() => _WorkoutTimerDisplayState();
}

class _WorkoutTimerDisplayState extends State<WorkoutTimerDisplay> {
  Phase _phase = Phase.initialCountdown;

  int _round = 0;
  int _seconds = 10;
  bool _setup = true;

  int _currentBlock = 0;
  int _roundsToComplete = 0;

  onPhaseComplete() {
    switch (_phase) {
      case Phase.initialCountdown:
        _phase = Phase.upWork;
        _roundsToComplete = widget.config.blocks[0].rounds;

        setState(() {
          _setup = false;
          _seconds = widget.config.blocks[0].phaseUpWork;
          _round = 1;
        });
        break;
      case Phase.upWork:
        _phase = Phase.downRest;

        setState(() {
          _seconds = widget.config.blocks[_currentBlock].phaseDownRest;
        });
        break;
      case Phase.downRest:
        if ((_round + 1) > _roundsToComplete) {
          _currentBlock++;

          if (_currentBlock < widget.config.blocks.length) {
            _roundsToComplete += widget.config.blocks[_currentBlock].rounds;
          }
        }

        if (_round + 1 <= _roundsToComplete) {
          _phase = Phase.upWork;

          setState(() {
            _seconds = widget.config.blocks[_currentBlock].phaseUpWork;
            _round++;
          });
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end, // align widgets to bottom
      children: [
        Expanded(
          flex: 12,
          child: Opacity(
              opacity: _setup ? 0.0 : 1.0, child: RoundsCounter(round: _round)),
        ),
        Expanded(flex: 3, child: Container()),
        Expanded(
          flex: 40,
          child: DigitalTimer(
            targetInSeconds: _seconds,
            onEnd: onPhaseComplete,
            setup: _setup,
          ),
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
              WorkoutTimerDisplay(
                config: workoutConfig,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
