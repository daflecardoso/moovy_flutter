import 'package:flutter/material.dart';

class MoovyGradient extends StatelessWidget {
  const MoovyGradient({super.key});

  @override
  Widget build(BuildContext context) {
    const green = Color(0xFF38B975);
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.black54, green],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.center,
              radius: 0.1,
              colors: [Colors.transparent, Colors.black54],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.bottomCenter,
              radius: 0.7,
              colors: [Colors.black, Colors.black38],
            ),
          ),
        ),
      ],
    );
  }
}
