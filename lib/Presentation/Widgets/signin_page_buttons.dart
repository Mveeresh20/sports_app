import 'package:flutter/material.dart';
import 'package:sports_app/Utils/Constants/ui.dart';

class SigninPageButtons extends StatelessWidget {
  final String buttonText;
  
  final VoidCallback onpressed;
  final Icon? icon;

  const SigninPageButtons({
    required this.buttonText,
    
    required this.onpressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 353,
      
      height: 50,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFF23943), Color(0xFFC1232C)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Color(0x2627DEBF),
            offset: Offset(0, 2),
            blurRadius: 12,
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
