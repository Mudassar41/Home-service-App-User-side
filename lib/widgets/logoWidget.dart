
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:user_side/utils/sizing.dart';

class LogoWidget extends StatelessWidget {
  double size;
  String title;
  String subTitle;

  LogoWidget(this.size, this.title, this.subTitle);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: Sizing.heightMultiplier * 6,
          right: Sizing.heightMultiplier * 6),
      child: Column(
        children: [
          Container(
              height: size,
              decoration: BoxDecoration(

                  image: DecorationImage(
                      image: AssetImage('assets/images/logo.jpeg'),
                      fit: BoxFit.fill))),
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Sizing.textMultiplier * 3),
          ),
          Text(
            subTitle,
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
