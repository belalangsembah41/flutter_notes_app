import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final double? btnWidth;
  final double? btnHeight;
  final double? btnFontSize;
  final void Function()? onPressed;
  const Button(
      {super.key,
      required this.label,
      this.btnWidth = double.infinity,
      this.btnHeight = 35,
      this.btnFontSize = 15,
      this.onPressed,
      required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: btnWidth,
      height: btnHeight,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Container(
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: btnFontSize,
            ),
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
