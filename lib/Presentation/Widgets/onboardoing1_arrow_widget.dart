// import 'package:flutter/material.dart';
// import 'package:sports_app/Utils/Constants/ui.dart';
// class Onboardoing1ArrowWidget extends StatelessWidget {
  
 
//   final VoidCallback onpressed;

//   const Onboardoing1ArrowWidget({
    
    
//     required this.onpressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
      
      
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             Color(0xFFF23943),
//             Color(0xFFC1232C),
//           ],
//         ),
//         borderRadius: BorderRadius.circular(20),
       
        
//       ),
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.transparent,
//           shadowColor: Colors.transparent,
//           shape: RoundedRectangleBorder(
//             borderRadius: UI.borderRadius32,
//           ),
//         ),
//         onPressed: onpressed,
//         child: Icon(Icons.arrow_forward)
//       ),
//     );
//   }
// }