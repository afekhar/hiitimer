import 'package:flutter/material.dart';

import 'package:hiitimer/theme.dart';
import 'package:hiitimer/workout_config.dart';
import 'package:hiitimer/timer_config_block.dart';

class TimerConfigDialog extends StatefulWidget {
  const TimerConfigDialog(
      {super.key, required this.timerConfig, required this.onClose});

  final WorkoutConfig? timerConfig;
  final VoidCallback onClose;

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
            "Un timer doit contenir au moins un bloc. "
            "Vous ne pouvez pas supprimer le dernier bloc.",
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
      color: primary800.withAlpha(75),
      padding: EdgeInsets.all(20.0),
      child: SafeArea(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: primary950,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: primary700),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(left: 20.0, top: 20.0, right: 80.0),
                    child: Text(
                      widget.timerConfig!.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontFamily: 'BalooTamma2',
                          fontWeight: FontWeight.w600,
                          fontSize: 30.0,
                          color: primary100),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Expanded(
                      child: ListView(
                    children: _blocks
                        .asMap()
                        .entries
                        .map((entry) => Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 15.0),
                              child: TimerConfigBlock(
                                index: entry.key,
                                block: entry.value,
                                onBlockChange: (index, bloc) =>
                                    blockChanged(index, bloc, context),
                                onAddBlock: (index) => addBlock(index, context),
                                onRemoveBlock: (index) =>
                                    removeBlock(index, context),
                              ),
                            ))
                        .toList(),
                  ))
                ],
              ),
            ),
            Positioned(
              top: 15.0,
              right: 15.0,
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
            )
          ],
        ),
      ),
    );
  }
}
