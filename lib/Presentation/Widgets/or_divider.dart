import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  final Color? color;
  final double thickness;
  final double indent;
  final double endIndent;
  final TextStyle? textStyle;

  const OrDivider({
    Key? key,
    this.color,
    this.thickness = 1.0,
    this.indent = 20.0,
    this.endIndent = 20.0,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultColor = color ?? Theme.of(context).dividerColor;
    final defaultTextStyle = textStyle ??
        TextStyle(color: defaultColor.withOpacity(0.6), fontSize: 16.0);

    return Row(
      children: [
        Expanded(
          child: Divider(
            color: defaultColor,
            thickness: thickness,
            indent: indent,
            endIndent: 10.0, // Adjust spacing
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            'or',
            style: defaultTextStyle,
          ),
        ),
        Expanded(
          child: Divider(
            color: defaultColor,
            thickness: thickness,
            indent: 10.0, // Adjust spacing
            endIndent: endIndent,
          ),
        ),
      ],
    );
  }
}



