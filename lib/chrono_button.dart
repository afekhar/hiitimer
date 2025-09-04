import 'dart:math';
import 'dart:async';

import 'package:flutter/material.dart';

enum ChronoButtonType { play, stop, pause, replay, close }

class ChronoButtonEventBus {
  // Singleton
  ChronoButtonEventBus._privateConstructor();
  static final ChronoButtonEventBus _instance = ChronoButtonEventBus._privateConstructor();
  factory ChronoButtonEventBus() => _instance;

  final _controller = StreamController<ChronoButtonType>.broadcast();

  // To emit an event
  void emit(ChronoButtonType event) {
    _controller.add(event);
  }

  // To subscribe to events
  Stream<ChronoButtonType> get stream => _controller.stream;

  void dispose() {
    _controller.close();
  }
}

class ChronoButtonsBar extends StatefulWidget {
  const ChronoButtonsBar({super.key, required this.buttons});

  final List<ChronoButtonType> buttons;

  @override
  State<ChronoButtonsBar> createState() => _ChronoButtonsBarState();
}

class _ChronoButtonsBarState extends State<ChronoButtonsBar> {
  @override
  void didChangeDependencies() {
    final List<String> buttons = ChronoButtonType.values.map((e) => e.name).toList();

    for (final button in buttons) {
      precacheImage(
          AssetImage('assets/images/buttons/chrono_$button.png'), context);
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: widget.buttons.map((buttonType) => ChronotButton(type: buttonType),).toList(),
    );
  }
}

class ChronotButton extends StatelessWidget {
  const ChronotButton({super.key, required this.type});

  final ChronoButtonType type;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double buttonHeight = min(50, constraints.maxHeight);

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 0),
          child: SizedBox(
            height: buttonHeight,
            width: buttonHeight,
            child: InkWell(
              borderRadius: BorderRadius.circular(buttonHeight),
              onTap: () => {
                ChronoButtonEventBus().emit(type)
              },
              child: Ink(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/buttons/chrono_${type.name}.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
