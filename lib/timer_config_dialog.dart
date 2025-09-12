import 'dart:developer' as dev;
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:hiitimer/theme.dart';
import 'package:hiitimer/workout_config.dart';
import 'package:hiitimer/timer_config_block.dart';

class TimerConfigButton extends StatelessWidget {
  const TimerConfigButton(
      {super.key,
      required this.label,
      required this.color,
      required this.onTap});

  final String label;
  final Color color;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(50.0),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'BalooTamma2',
                fontSize: 20.0,
                fontWeight: FontWeight.w900,
                color: primary50,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TimerConfigDialog extends StatefulWidget {
  const TimerConfigDialog(
      {super.key,
      required this.timerConfig,
      required this.onClose,
      required this.onLaunchTimer});

  final WorkoutConfig? timerConfig;
  final VoidCallback onClose;
  final Function(WorkoutConfig) onLaunchTimer;

  @override
  State<TimerConfigDialog> createState() => _TimerConfigDialogState();
}

class _TimerConfigDialogState extends State<TimerConfigDialog> {
  List<TimerBlock> _blocks = [];

  blockChanged(int index, TimerBlock block, BuildContext context) {
    setState(() {
      _blocks = _blocks
          .asMap()
          .entries
          .map((entry) => (entry.key == index) ? block : entry.value)
          .toList();
    });
  }

  removeBlock(int index, BuildContext context) {
    if (_blocks.length > 1) {
      setState(() {
        _blocks = _blocks
            .asMap()
            .entries
            .where((entry) => entry.key != index)
            .map((entry) => entry.value)
            .toList();
      });
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Suppression impossible"),
          content: const Text(
            "Un timer doit contenir au moins un bloc. ",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  addBlock(int index, BuildContext context) {
    final block = _blocks
        .asMap()
        .entries
        .where((entry) => entry.key == index)
        .first
        .value;

    setState(() {
      _blocks = [
        ..._blocks.sublist(0, index + 1),
        block,
        ..._blocks.sublist(index + 1)
      ];
    });
  }

  saveConfig(WorkoutConfig cfg) async {
    const String alnum =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';

    final rng = Random();
    final codeUnits = List.generate(
      16,
      (_) => alnum.codeUnitAt(
        rng.nextInt(alnum.length),
      ),
    );

    final key = String.fromCharCodes(codeUnits);
    final box = Hive.box<WorkoutConfig>('timers');

    await box.put(key, cfg);
  }

  @override
  void initState() {
    super.initState();

    if (widget.timerConfig != null) {
      _blocks = [...widget.timerConfig!.blocks];
    } else {
      _blocks = [];
    }
  }

  @override
  void didUpdateWidget(covariant TimerConfigDialog oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.timerConfig != null) {
      _blocks = [...widget.timerConfig!.blocks];
    } else {
      _blocks = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.timerConfig == null) {
      return SizedBox.shrink();
    }

    return Container(
      color: primary950.withAlpha(200),
      height: double.infinity,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: primary950,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: primary800),
              ),
              child: Stack(
                children: [
                  Column(
                    mainAxisSize:
                        MainAxisSize.min, // Shrink as much as possible
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, top: 20.0, right: 80.0),
                        child: Text(
                          widget.timerConfig!.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: 'BalooTamma2',
                            fontWeight: FontWeight.w600,
                            fontSize: 30.0,
                            color: primary100,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height *
                              0.70, // Aproximativ limit
                        ),
                        child: ListView(
                          shrinkWrap: true, // Adapt to content if smaller
                          children: [
                            ..._blocks.asMap().entries.map(
                                  (entry) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 15.0),
                                    child: TimerConfigBlock(
                                      index: entry.key,
                                      block: entry.value,
                                      onBlockChange: (index, bloc) =>
                                          blockChanged(index, bloc, context),
                                      onAddBlock: (index) =>
                                          addBlock(index, context),
                                      onRemoveBlock: (index) =>
                                          removeBlock(index, context),
                                    ),
                                  ),
                                ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 30.0,
                                bottom: 50.0,
                              ),
                              child: Column(
                                children: [
                                  TimerConfigButton(
                                    label: "Lancer sans enregistrer",
                                    color: Colors.blue,
                                    onTap: () => widget.onLaunchTimer(
                                      WorkoutConfig(
                                        name: widget.timerConfig!.name,
                                        blocks: _blocks,
                                      ),
                                    ),
                                  ),
                                  TimerConfigButton(
                                    label: "Enregistrer puis lancer",
                                    color: Colors.green,
                                    onTap: () {
                                      WorkoutConfig cfg = WorkoutConfig(
                                        name: widget.timerConfig!.name,
                                        blocks: _blocks,
                                      );

                                      saveConfig(cfg);
                                      widget.onLaunchTimer(cfg);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 20.0,
                    right: 20.0,
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: primary300.withAlpha(75),
                      child: IconButton(
                        onPressed: widget.onClose,
                        icon: const Icon(
                          Icons.close,
                          size: 15.0,
                          color: primary50,
                        ),
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
