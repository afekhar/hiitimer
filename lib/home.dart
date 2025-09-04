import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:hiitimer/chrono.dart';
import 'package:hiitimer/workout_config.dart';

const tabata = WorkoutConfig(name: 'TABATA/HIIT', blocks: [
  TimerBlock(phaseUpWork: 20, phaseDownRest: 10, rounds: 7),
  TimerBlock(phaseUpWork: 20, phaseDownRest: 0, rounds: 1),
]);

const testWorkout = WorkoutConfig(name: 'Test', blocks: [
  TimerBlock(phaseUpWork: 10, phaseDownRest: 0, rounds: 1),
  TimerBlock(phaseUpWork: 5, phaseDownRest: 0, rounds: 2),
  TimerBlock(phaseUpWork: 3, phaseDownRest: 0, rounds: 1),
]);

class Home extends StatefulWidget {
  const Home({super.key, required String title});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String title = 'Home';
  bool _navigatingToChronoPage = false;

  Future<void> launchChrono(BuildContext context) async {
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
        return Chrono(workoutConfig: tabata);
      }),
    );

    setState(() {
      _navigatingToChronoPage = false;
    });

    if (!context.mounted) return; // Using mounted checks after every async gap.

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
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Welcome to HIITimer',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () => launchChrono(context),
              child: Text('Launch Timer!')),
          SizedBox(
            height: 60,
          ),
        ],
      )),
    );
  }
}
