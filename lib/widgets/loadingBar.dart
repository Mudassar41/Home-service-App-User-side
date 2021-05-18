import 'package:flutter/material.dart';
import 'package:user_side/animations/rotationAnimation.dart';

class LoadingBar extends StatefulWidget {
  @override
  _LoadingBarState createState() => _LoadingBarState();
}

class _LoadingBarState extends State<LoadingBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(child: RotationAnimation(100, 100)),
      ),
    );
  }
}
