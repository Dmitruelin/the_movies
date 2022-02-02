import 'package:flutter/cupertino.dart';

class CustomPageRoute extends PageRouteBuilder {
  final Widget child;

  CustomPageRoute({required this.child})
      : super(
            transitionDuration: const Duration(milliseconds: 800),
            reverseTransitionDuration: const Duration(milliseconds: 200),
            pageBuilder: (context, animation, secondaryAnimation) => child);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    const curve = Curves.easeInOutBack;
    const begin = Offset(1, 0.5);
    const end = Offset.zero;
    var tween = Tween(
      begin: begin,
      end: end,
    ).chain(CurveTween(curve: curve));
    return SlideTransition(position: animation.drive(tween), child: child);
  }
}
