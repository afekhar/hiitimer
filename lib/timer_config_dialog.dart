import 'package:flutter/material.dart';

import 'package:hiitimer/theme.dart';
import 'package:hiitimer/workout_config.dart';
import 'package:hiitimer/timer_config_block.dart';

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
                              child: Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () {
                                        widget.onLaunchTimer(
                                          WorkoutConfig(
                                            name: widget.timerConfig!.name,
                                            blocks: _blocks,
                                          ),
                                        );
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15.0, horizontal: 30.0),
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Lancer le timer",
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
                                  ],
                                ),
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
