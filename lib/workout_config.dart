import 'package:hive/hive.dart';

part 'workout_config.g.dart';

@HiveType(typeId: 0)
class TimerBlock {
  const TimerBlock({required this.intervals, required this.rounds});

  TimerBlock.from(TimerBlock other)
      : intervals = [...other.intervals],
        rounds = other.rounds;

  @HiveField(0)
  final List<int> intervals;

  @HiveField(1)
  final int rounds;
}

@HiveType(typeId: 1)
class WorkoutConfig {
  WorkoutConfig({required this.name, required this.blocks})
      : createdAt = DateTime.now();

  @HiveField(0)
  final String name;

  @HiveField(1)
  final List<TimerBlock> blocks;

  @HiveField(2)
  final DateTime createdAt;
}
