import 'package:flutter/material.dart';

import 'fullwidth_button_style.dart';

class FullwdithButton extends StatelessWidget {
  final Widget child;
  final Function onPressed;
  final double width;
  final Color backgroundColor;
  final Color outlineColor;
  final double radius;

  FullwdithButton({super.key, required this.onPressed, required this.width, this.outlineColor = Colors.transparent,
    required this.backgroundColor, this.radius = 8, required this.child});


  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.width,
      height:MediaQuery.of(context).size.height * fullwidthButtonHeight,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(this.backgroundColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  side: fullwidthButtonOutline(this.outlineColor),
                  borderRadius: fullwidthButtonRadius(this.radius),
                )
            )
        ),
        onPressed: () => onPressed(),
        child: child,
      ),
    );
  }
}
