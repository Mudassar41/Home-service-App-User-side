import 'package:flutter/material.dart';

class AlertAnimation extends StatefulWidget {
 final  Widget child;
  AlertAnimation({@required this.child});
  @override
  _AlertAnimationState createState() => _AlertAnimationState();
}

class _AlertAnimationState extends State<AlertAnimation>
    with TickerProviderStateMixin {
  AnimationController animController;
  Animation<double> animation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AnimationController animController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    animation = CurvedAnimation(
      parent: animController,
      curve: Curves.bounceOut,
    );
  }

  @override
  void dispose() {
  //  animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FadeTransition(
        opacity: animation,
        child: widget.child,
      ),
    );
  }
}
