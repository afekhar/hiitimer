class TimerBlock {
  const TimerBlock(
      {required this.phases,
      required this.rounds});

  final List<int> phases;
  final int rounds;
}

class WorkoutConfig {
  const WorkoutConfig({required this.name, required this.blocks});

  final String name;
  final List<TimerBlock> blocks;
}
