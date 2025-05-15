import 'package:flutter/material.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({
    super.key,
    required this.icon,
    required this.name,
    required this.arrowIcon,
    this.onClick,
    this.isLast = false,
    this.editGradient
  });
  final IconData icon;
  final String name;
  final IconData arrowIcon;
  final VoidCallback? onClick;
  final bool isLast;
  final Gradient? editGradient;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,

      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    editGradient!= null?
                    ShaderMask(shaderCallback: (bounds)=>editGradient!.createShader(bounds),child:     Icon(icon, color: Colors.white),) :    Icon(icon, color: Colors.white),

                
                    SizedBox(width: 10),
                    Text(
                      name,
                      style: TextStyle(
                        fontFamily: "Plus Jakarta Sans",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Icon(arrowIcon, color: Color(0xFF7B8A99)),
              ],
            ),
          ),
          if (!isLast)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17),
              child: Container(
                height: 1,
                decoration: BoxDecoration(
                  color: Color(0xFF2B2B2B),
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xFF1E2730),
                      width: 1,
                    ), // Only bottom border with 1px width
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
