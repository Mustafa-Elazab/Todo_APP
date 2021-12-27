import 'package:flutter/material.dart';
import 'package:todo_app/app/ui/theme/theme.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Function()? onTap;
  final double width;
  final double height;
  final Color color;
  final Color textColor;

  const CustomButton(
      {Key? key,
      required this.title,
      required this.onTap,
      required this.width,
      required this.height,
      this.color = blueColor,
      this.textColor = whiteColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: color,
        ),
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(color: textColor, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
