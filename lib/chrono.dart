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

class ChronoHeader extends StatefulWidget {
  const ChronoHeader(
      {super.key, required this.timerName, required this.buttons});

  final String timerName;
  final List<ChronoButtonType> buttons;

  @override
  State<ChronoHeader> createState() => _ChronoHeaderState();
}

class _ChronoHeaderState extends State<ChronoHeader> {
  bool _inPauseMode = false;

  @override
  void initState() {
    super.initState();

    ChronoButtonEventBus().stream.listen((event) {
      if (!mounted) return;

      switch (event) {
        case ChronoButtonType.pause:
          setState(() {
            _inPauseMode = true;
          });
          break;
        default:
          setState(() {
            _inPauseMode = false;
          });
          break;
      }
    });
  }

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
                      fontSize: 60,
                      fontFamily: "SofiaSansExtraCondensed",
                      fontWeight: FontWeight.w900,
                      color: primary700,
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
        ChronoButtonsBar(
          buttons: widget.buttons,
        ),
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
  const WorkoutTimerDisplay({
    super.key,
    required this.config,
    required this.status,
    this.onComplete,
  });

  final WorkoutConfig config;
  final DigitalTimerStatus status;
  final Function? onComplete;

  @override
  State<WorkoutTimerDisplay> createState() => _WorkoutTimerDisplayState();
}

class _WorkoutTimerDisplayState extends State<WorkoutTimerDisplay> {
  Phase _phase = Phase.initialCountdown;

  int _round = 0;
  DigitalTimerSeconds _seconds = DigitalTimerSeconds(seconds: 10);
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
          _seconds =
              DigitalTimerSeconds(seconds: widget.config.blocks[0].phaseUpWork);
          _round = 1;
        });
        break;
      case Phase.upWork:
        _phase = Phase.downRest;

        setState(() {
          _seconds = DigitalTimerSeconds(
              seconds: widget.config.blocks[_currentBlock].phaseDownRest);
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
            _seconds = DigitalTimerSeconds(
                seconds: widget.config.blocks[_currentBlock].phaseUpWork);
            _round++;
          });
        } else {
          if (widget.onComplete != null) {
            widget.onComplete!();
          }

          WakelockPlus.disable();
        }
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    WakelockPlus.enable();

    ChronoButtonEventBus().stream.listen((event) {
      if (!mounted) return;

      if (event == ChronoButtonType.stop || event == ChronoButtonType.replay) {
        _phase = Phase.initialCountdown;
        _currentBlock = 0;
        _roundsToComplete = 0;

        setState(() {
          _round = 0;
          _seconds = DigitalTimerSeconds(seconds: 10);
          _setup = true;
        });
      }
    });
  }

  @override
  void dispose() {
    WakelockPlus.disable();
    super.dispose();
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
            status: widget.status,
          ),
        ),
      ],
    );
  }
}

class Chrono extends StatefulWidget {
  const Chrono({super.key, required this.workoutConfig});

  final WorkoutConfig workoutConfig;

  @override
  State<Chrono> createState() => _ChronoState();
}

class _ChronoState extends State<Chrono> {
  DigitalTimerStatus _timerDisplayStatus = DigitalTimerStatus.idle;
  List<ChronoButtonType> _headerButtons = [
    ChronoButtonType.play,
    ChronoButtonType.close
  ];

  _workoutCompleted() {
    setState(() {
      _timerDisplayStatus = DigitalTimerStatus.idle;
      _headerButtons = [
        ChronoButtonType.replay,
        ChronoButtonType.close,
      ];
    });
  }

  @override
  void initState() {
    super.initState();

    ChronoButtonEventBus().stream.listen((event) {
      if (!mounted) return;

      switch (event) {
        case ChronoButtonType.close:
          Navigator.pop(context);
          break;
        case ChronoButtonType.play:
        case ChronoButtonType.replay:
          setState(() {
            _timerDisplayStatus = DigitalTimerStatus.playing;
            _headerButtons = [
              ChronoButtonType.pause,
              ChronoButtonType.stop,
              ChronoButtonType.close
            ];
          });
          break;
        case ChronoButtonType.pause:
          setState(() {
            _timerDisplayStatus = DigitalTimerStatus.paused;
            _headerButtons = [ChronoButtonType.play, ChronoButtonType.close];
          });
          break;
        case ChronoButtonType.stop:
          setState(() {
            _timerDisplayStatus = DigitalTimerStatus.stopped;
            _headerButtons = [ChronoButtonType.play, ChronoButtonType.close];
          });
          break;
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
              Expanded(
                child: ChronoHeader(
                  timerName: widget.workoutConfig.name,
                  buttons: _headerButtons,
                ),
              ),
              WorkoutTimerDisplay(
                config: widget.workoutConfig,
                status: _timerDisplayStatus,
                onComplete: _workoutCompleted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
