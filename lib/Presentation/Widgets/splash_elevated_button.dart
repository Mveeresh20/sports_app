import 'package:flutter/material.dart';
import 'package:sports_app/Utils/Constants/ui.dart';

class SplashElevatedButton extends StatelessWidget {
  final String buttonText;
  final double width;
  final VoidCallback onpressed;

  const SplashElevatedButton({
    required this.buttonText,
    required this.width,
    required this.onpressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 50,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFF23943), Color(0xFFC1232C)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 4),
            blurRadius: 5.0,
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: UI.borderRadius36),
        ),
        onPressed: onpressed,
        child: Text(
          buttonText,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
