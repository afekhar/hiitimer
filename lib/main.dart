import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:hiitimer/theme.dart';
import 'package:hiitimer/home.dart';

import 'workout_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(TimerBlockAdapter());
  Hive.registerAdapter(WorkoutConfigAdapter());

  await Hive.openBox<WorkoutConfig>('timers');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HIITimer',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: const Home(),
    );
  }
}
