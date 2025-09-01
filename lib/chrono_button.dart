import 'dart:math';
import 'package:flutter/material.dart';

class ChronotButton extends StatelessWidget {
  const ChronotButton({super.key, required this.type});

  final String type;

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
              onTap: () => {},
              child: Ink(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/buttons/chrono_$type.png'),
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
