import 'package:flutter/material.dart';

class Barwidget extends StatelessWidget {
  final AnimationController animController;

  const Barwidget({
    Key? key,
    required this.animController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1.5),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: <Widget>[
              _barcontainer(
                double.infinity,
                Colors.grey,
              ),
              AnimatedBuilder(
                animation: animController,
                builder: (context, child) {
                  return _barcontainer(
                      constraints.maxWidth * animController.value,
                      Colors.white);
                },
              )
            ],
          );
        },
      ),
    );
  }

  Container _barcontainer(double width, Color color) {
    return Container(
      height: 5.0,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(3.0),
      ),
    );
  }
}
