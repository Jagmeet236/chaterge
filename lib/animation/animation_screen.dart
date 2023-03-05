import 'package:flutter/material.dart';

class ImageFadeAnimation extends StatefulWidget {
  final String assetName;
  final double height;

  ImageFadeAnimation({required this.assetName, this.height = 200.0});

  @override
  _ImageFadeAnimationState createState() => _ImageFadeAnimationState();
}

class _ImageFadeAnimationState extends State<ImageFadeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Container(
        height: widget.height,
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Opacity(
              opacity: _animation.value,
              child: child,
            );
          },
          child: Image.asset(
            widget.assetName,
          ),
        ),
      ),
    );
  }
}

class ImageSlideAnimation extends StatefulWidget {
  final String assetName;
  final double height;

  ImageSlideAnimation({required this.assetName, this.height = 200.0});

  @override
  _ImageSlideAnimationState createState() => _ImageSlideAnimationState();
}

class _ImageSlideAnimationState extends State<ImageSlideAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _animation = Tween<Offset>(
      begin: Offset(-1, 0),
      end: Offset.zero,
    ).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      child: SlideTransition(
        position: _animation,
        child: Image.asset(
          widget.assetName,
        ),
      ),
    );
  }
}
