import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:hiitimer/chrono.dart';
import 'package:hiitimer/workout_config.dart';
import 'package:hiitimer/timer_selector.dart';
import 'package:hiitimer/timer_config_dialog.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _navigatingToChronoPage = false;
  WorkoutConfig? _currentConfig;

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

  _closeTimerConfig() async {
    await _launchChrono(context, _currentConfig!);

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
            TimerSelector(
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
