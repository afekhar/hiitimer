import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:hiitimer/chrono.dart';
import 'package:hiitimer/theme.dart';
import 'package:hiitimer/workout_config.dart';

const List<WorkoutConfig> cfgs = [
  WorkoutConfig(
    name: 'TABATA/HIIT',
    blocks: [
      TimerBlock(phases: [20, 10], rounds: 7),
      TimerBlock(phases: [20], rounds: 1),
    ],
  ),
  WorkoutConfig(
    name: 'EMOM',
    blocks: [
      TimerBlock(phases: [60, 60, 60], rounds: 5),
    ],
  ),
  WorkoutConfig(
    name: 'wod_05092509270',
    blocks: [
      TimerBlock(phases: [10], rounds: 1),
      TimerBlock(phases: [5], rounds: 2),
      TimerBlock(phases: [3], rounds: 1),
    ],
  ),
  // WorkoutConfig(
  //   name: 'TABATA',
  //   blocks: [
  //     TimerBlock(phases: [20, 10], rounds: 7),
  //     TimerBlock(phases: [20], rounds: 1),
  //   ],
  // ),
  // WorkoutConfig(
  //   name: 'E1MOM',
  //   blocks: [
  //     TimerBlock(phases: [60, 60, 60], rounds: 5),
  //   ],
  // ),
  // WorkoutConfig(
  //   name: 'wod_05092509270',
  //   blocks: [
  //     TimerBlock(phases: [10], rounds: 1),
  //     TimerBlock(phases: [5], rounds: 2),
  //     TimerBlock(phases: [3], rounds: 1),
  //   ],
  // ),
  // WorkoutConfig(
  //   name: 'TABATA',
  //   blocks: [
  //     TimerBlock(phases: [20, 10], rounds: 7),
  //     TimerBlock(phases: [20], rounds: 1),
  //   ],
  // ),
  // WorkoutConfig(
  //   name: 'E1MOM',
  //   blocks: [
  //     TimerBlock(phases: [60, 60, 60], rounds: 5),
  //   ],
  // ),
  // WorkoutConfig(
  //   name: 'wod_05092509270',
  //   blocks: [
  //     TimerBlock(phases: [10], rounds: 1),
  //     TimerBlock(phases: [5], rounds: 2),
  //     TimerBlock(phases: [3], rounds: 1),
  //   ],
  // ),
  // WorkoutConfig(
  //   name: 'TABATA',
  //   blocks: [
  //     TimerBlock(phases: [20, 10], rounds: 7),
  //     TimerBlock(phases: [20], rounds: 1),
  //   ],
  // ),
  // WorkoutConfig(
  //   name: 'E1MOM',
  //   blocks: [
  //     TimerBlock(phases: [60, 60, 60], rounds: 5),
  //   ],
  // ),
  // WorkoutConfig(
  //   name: 'wod_05092509270',
  //   blocks: [
  //     TimerBlock(phases: [10], rounds: 1),
  //     TimerBlock(phases: [5], rounds: 2),
  //     TimerBlock(phases: [3], rounds: 1),
  //   ],
  // ),
  // WorkoutConfig(
  //   name: 'TABATA',
  //   blocks: [
  //     TimerBlock(phases: [20, 10], rounds: 7),
  //     TimerBlock(phases: [20], rounds: 1),
  //   ],
  // ),
  // WorkoutConfig(
  //   name: 'E1MOM',
  //   blocks: [
  //     TimerBlock(phases: [60, 60, 60], rounds: 5),
  //   ],
  // ),
  // WorkoutConfig(
  //   name: 'wod_05092509270',
  //   blocks: [
  //     TimerBlock(phases: [10], rounds: 1),
  //     TimerBlock(phases: [5], rounds: 2),
  //     TimerBlock(phases: [3], rounds: 1),
  //   ],
  // ),
];

class TimersChooser extends StatelessWidget {
  const TimersChooser({super.key, required this.showTimerConfig});

  final Function showTimerConfig;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return ListView(
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight, // occupe tout l’écran
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end, // aligne en bas
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.only(
                              left: 10.0, right: 10.0, bottom: 20.0, top: 5.0),
                          decoration: BoxDecoration(
                            color: primary900.withAlpha(220),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 20.0),
                                child: Text(
                                  'Choisis ton timer',
                                  style: TextStyle(
                                      fontFamily: 'BalooTamma2',
                                      fontSize: 28,
                                      fontWeight: FontWeight.w500,
                                      color: primary400),
                                ),
                              ),
                              ...cfgs.map(
                                (cfg) => Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                  child: GestureDetector(
                                    onTap: () =>
                                        // _launchChrono(context, cfg),
                                        showTimerConfig(cfg),
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(16.0),
                                      decoration: BoxDecoration(
                                          color: primary800.withAlpha(150),
                                          border: const Border(
                                            top: BorderSide(
                                                color: primary700, width: 1.0),
                                            bottom: BorderSide(
                                                color: primary900, width: 2.0),
                                          )),
                                      child: Text(
                                        cfg.name,
                                        style: TextStyle(
                                            fontFamily: 'BalooTamma2',
                                            fontSize: 20,
                                            fontWeight: FontWeight.w900,
                                            color: primary200),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class TimerConfigDialog extends StatelessWidget {
  const TimerConfigDialog(
      {super.key, required this.timerConfig, required this.onClose});

  final WorkoutConfig? timerConfig;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    if (timerConfig == null) {
      return SizedBox.shrink();
    }

    return Container(
      color: primary800.withAlpha(75),
      padding: EdgeInsets.all(20.0),
      child: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: primary950,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: primary700),
              ),
            ),
            Positioned(
              top: 20.0,
              right: 20.0,
              child: CircleAvatar(
                radius: 20,
                backgroundColor: primary300.withAlpha(75),
                child: IconButton(
                  onPressed: onClose,
                  icon: const Icon(
                    Icons.close,
                    size: 20.0,
                    color: primary50,
                  ),
                  padding: EdgeInsets.zero,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _navigatingToChronoPage = false;
  WorkoutConfig? _currentConfig = null;

  _openTimerConfig(WorkoutConfig cfg) {
    setState(() {
      _currentConfig = cfg;
    });
  }

  Future<void> _launchChrono(BuildContext context, WorkoutConfig cfg) async {
    // To avoir losing context in async gaps, we start by retaining it.

    final nav = Navigator.of(context);
    final navFuture = nav.push(MaterialPageRoute(
      builder: (_) => Chrono(workoutConfig: cfg),
    ));

    setState(() {
      _navigatingToChronoPage = true;
    });

    // Wait the next frame to avoid blocking navigation.
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeRight]);
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    });

    await navFuture;

    setState(() {
      _navigatingToChronoPage = false;
    });

    // After returning: switch back to portrait
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    // Show status bar and navigation bar again
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  _closeTimerConfig() {
    setState(() {
      _currentConfig = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_navigatingToChronoPage) {
      return Center(
        child: CircularProgressIndicator(), // Default spinner
      );
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg/home.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            TimersChooser(
              showTimerConfig: _openTimerConfig,
            ),
            TimerConfigDialog(
              timerConfig: _currentConfig,
              onClose: _closeTimerConfig,
            ),
          ],
        ),
      ),
    );
  }
}
