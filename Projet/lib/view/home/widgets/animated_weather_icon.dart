import 'package:flutter/material.dart';

class AnimatedWeatherIcon extends StatefulWidget {
  final String iconUrl;
  final String conditionCode; // e.g., '01d', '09n'

  const AnimatedWeatherIcon({
    Key? key,
    required this.iconUrl,
    required this.conditionCode,
  }) : super(key: key);

  @override
  State<AnimatedWeatherIcon> createState() => _AnimatedWeatherIconState();
}

class _AnimatedWeatherIconState extends State<AnimatedWeatherIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _setupAnimation();
  }

  void _setupAnimation() {
    final code = widget.conditionCode;

    if (code.startsWith('01')) {
      // Sunny/Clear: Rotate slowly
      _controller.duration = const Duration(seconds: 10);
      _controller.repeat();
    } else if (code.startsWith('09') || code.startsWith('10')) {
      // Rain: Move down
      _controller.duration = const Duration(milliseconds: 1500);
      _controller.repeat(reverse: true);
    } else if (code.startsWith('13')) {
      // Snow: Scale pulse
      _controller.duration = const Duration(seconds: 2);
      _controller.repeat(reverse: true);
    } else if (code.startsWith('02') || code.startsWith('03') || code.startsWith('04')) {
       // Clouds: Move Horizontal
      _controller.duration = const Duration(seconds: 4);
      _controller.repeat(reverse: true);
    } else {
      // Default: Gentle float
      _controller.duration = const Duration(seconds: 3);
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(covariant AnimatedWeatherIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.conditionCode != widget.conditionCode) {
      _controller.reset();
      _setupAnimation();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final code = widget.conditionCode;

    return SizedBox(
      height: 180,
      width: 180,
      child: AnimatedBuilder(
        animation: _controller,
        child: Image.asset(
          _getLocalAsset(code),
          fit: BoxFit.contain,
        ),
        builder: (context, child) {
          if (code.startsWith('01')) {
            // Sunny: Rotate
            return Transform.rotate(
              angle: _controller.value * 2 * 3.14159,
              child: child,
            );
          } else if (code.startsWith('09') || code.startsWith('10')) {
            // Rain: Translate Y (Drop effect)
            return Transform.translate(
              offset: Offset(0, 10 * _controller.value),
              child: child,
            );
          } else if (code.startsWith('13')) {
            // Snow: Scale Pulse
            return Transform.scale(
              scale: 1.0 + (0.15 * _controller.value),
              child: child,
            );
          } else if (code.startsWith('02') || code.startsWith('03') || code.startsWith('04')) {
             // Clouds: Float Horizontal
            return Transform.translate(
              offset: Offset(15 * (_controller.value - 0.5), 0),
              child: child,
            );
          } else {
             // Default: Gentle float Vertical
             return Transform.translate(
              offset: Offset(0, 10 * (_controller.value - 0.5)),
              child: child,
            );
          }
        },
      ),
    );
  }


  String _getLocalAsset(String code) {
    if (code.startsWith('01')) {
      return 'assets/cloud_sun.png';
    } else if (code.startsWith('02') || code.startsWith('03') || code.startsWith('04')) {
      return 'assets/clouds.png';
    } else if (code.startsWith('09') || code.startsWith('10')) {
      return 'assets/cloud_rain.png';
    } else if (code.startsWith('11')) {
      return 'assets/thunder_rain.png';
    } else {
      return 'assets/cloud_sun.png'; // Fallback
    }
  }
}
