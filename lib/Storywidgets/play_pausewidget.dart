import 'package:flutter/material.dart';

class Playpause extends StatefulWidget {
  final AnimationController animationcontroller;
  final VoidCallback playpause;
  const Playpause(
      {Key? key, required this.animationcontroller, required this.playpause})
      : super(key: key);

  @override
  State<Playpause> createState() => _PlaypauseState();
}

class _PlaypauseState extends State<Playpause> {
  @override
  Widget build(BuildContext context) {
    var _isplaying = widget.animationcontroller.isAnimating;
    return IconButton(
        onPressed: () {
          setState(() {
            widget.playpause();
            _isplaying = !_isplaying;
          });
        },
        icon: Icon(
          _isplaying ? Icons.pause : Icons.play_arrow_outlined,
          color: Colors.white,
          size: 35,
        ));
  }
}
