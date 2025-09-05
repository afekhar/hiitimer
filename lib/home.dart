import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:hiitimer/chrono.dart';
import 'package:hiitimer/theme.dart';
import 'package:hiitimer/workout_config.dart';

const List<WorkoutConfig> wods = [
  WorkoutConfig(
    name: 'TABATA',
    blocks: [
      TimerBlock(phases: [20, 10], rounds: 7),
      TimerBlock(phases: [20], rounds: 1),
    ],
  ),
  WorkoutConfig(
    name: 'E1MOM',
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

class Home extends StatefulWidget {
  const Home({super.key, required String title});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String title = 'Home';
  bool _navigatingToChronoPage = false;

  Future<void> launchChrono(BuildContext context, WorkoutConfig cfg) async {
    setState(() {
      _navigatingToChronoPage = true;
    });

    // Switch to landscape orientation
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
    ]);

    // Hide status bar and navigation bar
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    if (!context.mounted) return; // Check if the widget is still in the tree

    // Navigate to the landscape page
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) {
        return Chrono(workoutConfig: cfg);
      }),
    );

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
        child: SafeArea(
          child: Stack(
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  return ListView(
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight:
                              constraints.maxHeight, // occupe tout l’écran
                        ),
                        child: Column(
                          mainAxisAlignment:
                              MainAxisAlignment.end, // aligne en bas
                          children: [
                            Container(
                              // padding: const EdgeInsets.all(60.0),
                              decoration: BoxDecoration(
                                color: primary700.withAlpha(225),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: Text(
                                      'Choisis ton timer',
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  ...wods.map(
                                    (wod) => Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: ElevatedButton(
                                        onPressed: () =>
                                            launchChrono(context, wod),
                                        child: Text(wod.name),
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
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     Container(
              //       color: Colors.red,
              //       child: ListView(
              //         shrinkWrap: true,
              //         children: [
              //           Padding(
              //             padding: const EdgeInsets.symmetric(vertical: 10.0),
              //             child: Text(
              //               'Choisis ton timer',
              //               style: TextStyle(
              //                   fontSize: 24, fontWeight: FontWeight.w700),
              //             ),
              //           ),
              //           SizedBox(
              //             height: 20,
              //           ),
              //           ...wods.map(
              //             (wod) => Padding(
              //               padding: EdgeInsets.all(10.0),
              //               child: ElevatedButton(
              //                 onPressed: () => launchChrono(context, wod),
              //                 child: Text(wod.name),
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
