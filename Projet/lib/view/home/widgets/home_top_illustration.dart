import 'package:flutter/material.dart';

class HomeTopIllustration extends StatefulWidget {
  const HomeTopIllustration({
    Key? key,
    required this.screenSize,
    required this.climateDescription,
    required this.climate,
  }) : super(key: key);

  final Size screenSize;
  final String climateDescription;
  final String climate;

  @override
  State<HomeTopIllustration> createState() => _HomeTopIllustrationState();
}

class _HomeTopIllustrationState extends State<HomeTopIllustration>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0, end: 10).animate(
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
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: child,
        );
      },
      child: SizedBox(
        width: widget.screenSize.width * 0.65,
        height: widget.screenSize.height * 0.25,
        child: Image.asset((widget.climateDescription == 'moderate rain')
            ? 'assets/thunder_rain.png'
            : (widget.climate == 'Clear' || widget.climate == 'Clouds')
                ? 'assets/clouds.png'
                : (widget.climateDescription == 'light rain')
                    ? 'assets/cloud_rain.png'
                    : (widget.climateDescription == 'overcast clouds')
                        ? 'assets/thunder_rain.png'
                        : (widget.climate == 'Rain')
                            ? 'assets/thunder_rain.png'
                            : (widget.climate == 'Thunder')
                                ? 'assets/sun_thunder.png'
                                : 'assets/cloud_sun.png'),
      ),
    );
  }
}
