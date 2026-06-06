import 'dart:ui';

import 'package:flutter/material.dart';

class MoovyGlass extends StatelessWidget {
  final Widget child;
  const MoovyGlass({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Stack(
        children: [
          BackdropFilter(filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0), child: Container()),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white.withValues(alpha: 0.1),
              border: Border.all(color: Colors.white.withValues(alpha: 0.2), width: 1.5),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.white.withValues(alpha: 0.5), Colors.white.withValues(alpha: 0.5)],
              ),
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}
