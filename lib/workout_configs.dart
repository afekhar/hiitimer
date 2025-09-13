import 'package:hiitimer/workout_config.dart';

final List<WorkoutConfig> defaultConfigs = [
  WorkoutConfig(
    name: 'TABATA/HIIT',
    blocks: [
      TimerBlock(intervals: [20, 10], rounds: 7),
      TimerBlock(intervals: [20], rounds: 1),
    ],
  ),
  WorkoutConfig(
    name: 'EMOM',
    blocks: [
      TimerBlock(intervals: [60, 60, 60, 60], rounds: 3),
    ],
  ),
];
