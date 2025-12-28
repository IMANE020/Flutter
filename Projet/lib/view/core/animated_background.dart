import 'package:flutter/material.dart';

class AnimatedGradientBackground extends StatefulWidget {
  final Widget child;

  const AnimatedGradientBackground({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<AnimatedGradientBackground> createState() => _AnimatedGradientBackgroundState();
}

class _AnimatedGradientBackgroundState extends State<AnimatedGradientBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.lerp(
                  const Color(0xFFB8D7EB), // Base color
                  const Color(0xFFA8C7DB), // Slightly darker
                  _animation.value,
                )!,
                Color.lerp(
                  const Color(0xFFD0E5F2), // Lighter shade
                  const Color(0xFFB8D7EB), // Base color
                  _animation.value,
                )!,
                Color.lerp(
                  const Color(0xFFE8F4F8), // Very light
                  const Color(0xFFD0E5F2), // Lighter shade
                  _animation.value,
                )!,
              ],
              stops: [
                0.0 + (_animation.value * 0.1),
                0.5 + (_animation.value * 0.1),
                1.0,
              ],
            ),
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
