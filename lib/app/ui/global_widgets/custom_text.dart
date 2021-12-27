import 'package:flutter/material.dart';


class CustomText extends StatelessWidget {
  late String title;
  final double fontSize;
  final Color? color;
  final Alignment textAlignment;
  final FontWeight fontWeight;
  final int maxLines;
  final TextOverflow textOverflow;
  final double height;

   CustomText(
      {Key? key, 
      required this.title,
      this.fontSize = 14,
      this.color,
      this.textAlignment = Alignment.topLeft,
      this.fontWeight = FontWeight.normal,
      this.maxLines = 1,
      this.textOverflow = TextOverflow.ellipsis,
      this.height = 1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: textAlignment,
      child: Text(
        title,
        maxLines: maxLines,
        overflow: textOverflow,
        style: TextStyle(
            fontSize: fontSize,
            color: color,
            fontWeight: fontWeight,
            height: height),
      ),
    );
  }
}
