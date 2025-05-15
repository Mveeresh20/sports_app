import 'package:flutter/material.dart';
import 'package:sports_app/Utils/Constants/ui.dart';

class SkipButoon extends StatelessWidget {
  final String buttonText;
  
  final VoidCallback onpressed;
  final Icon? icon;

  const SkipButoon({
    required this.buttonText,
    
    required this.onpressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
         color: Color(0xFF454545),
          width: 1,
        ),
        
      ),
      
      width: 353,
      
      height: 45,
      
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
