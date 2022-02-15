import 'package:flutter/material.dart';

class AnimatedPage extends Page {
  final String path;
  final Widget child;
  final Map<String, dynamic>? args;
  final int transitionDuration, reverseTransitionDuration;

  AnimatedPage({
    required this.child,
    required this.path,
    this.args,
    this.transitionDuration = 400,
    this.reverseTransitionDuration = 400,
  }) : super(name: path, key: ValueKey(path), arguments: args);

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      transitionDuration: const Duration(seconds: 1),
      pageBuilder: (context, animation, animation2) {
        final tween = Tween(begin: const Offset(0.0, 1.0), end: Offset.zero);
        final curveTween = CurveTween(curve: Curves.easeInOut);
        return SlideTransition(
          position: animation.drive(curveTween).drive(tween),
          child: child,
        );
      },
    );
  }
}
