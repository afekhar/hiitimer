import 'package:flutter/material.dart';
import 'package:hiitimer/theme.dart';

class BottomOverlay extends StatefulWidget {
  const BottomOverlay({super.key, required this.child, this.show = false});

  final bool show;
  final Widget child;

  @override
  State<BottomOverlay> createState() => _BottomOverlayState();
}

class _BottomOverlayState extends State<BottomOverlay>
    with SingleTickerProviderStateMixin {
  OverlayEntry? _entry;
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 280),
    reverseDuration: const Duration(milliseconds: 220),
  );
  late final Animation<Offset> _slide = Tween<Offset>(
    begin: const Offset(0, 1), // start off-screen at bottom
    end: Offset.zero, // on-screen
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOutCubic,
    reverseCurve: Curves.easeInCubic,
  ));

  Future<void> _showOverlay() async {
    if (_entry != null) return;

    _entry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            // Dimmed background
            Container(color: primary950.withAlpha(200)),

            // Bottom-aligned panel that slides up
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 5.0,
                  right: 5.0,
                  top: 40.0,
                  bottom: 0.0,
                ),
                child: SlideTransition(
                  position: _slide,
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(),
                      ),
                      SizedBox(
                        width: double
                            .infinity, // remplit la largeur, pas la hauteur
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 40.0, horizontal: 20.0),
                          decoration: BoxDecoration(
                            color: primary300,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                            ),
                          ),
                          child: widget.child, // centre le contenu
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    Overlay.of(context).insert(_entry!);

    // optional delay before animating in
    await Future.delayed(const Duration(milliseconds: 180));
    if (mounted) await _controller.forward();
  }

  Future<void> _hideOverlay() async {
    if (_entry == null) return;
    await _controller.reverse(); // animate out
    _entry?.remove();
    _entry = null;
  }

  @override
  void dispose() {
    _entry?.remove();
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant BottomOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.show != oldWidget.show) {
      if (widget.show) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _showOverlay();
        });
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _hideOverlay();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.shrink();
  }
}
