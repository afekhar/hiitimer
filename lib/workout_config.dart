class TimerBlock {
  const TimerBlock(
      {required this.phaseUpWork,
      required this.phaseDownRest,
      required this.rounds});

  final int phaseUpWork;
  final int phaseDownRest;
  final int rounds;
}

class WorkoutConfig {
  const WorkoutConfig({required this.name, required this.blocks});

  final String name;
  final List<TimerBlock> blocks;
}
