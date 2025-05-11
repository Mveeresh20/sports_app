import 'package:flutter/material.dart';
import 'package:sports_app/Presentation/Views/profile_info.dart';
import 'package:sports_app/Utils/Constants/images.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF101922),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ).copyWith(top: 64),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.white,
                  size: 16,
                ),
                const SizedBox(width: 117),
                const Text(
                  "My Profile",
                  style: TextStyle(
                    fontFamily: "Plus Jakarta Sans",
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFF27313B),
                  width: 1,
                ), // Only bottom border with 1px width
              ),
            ),
          ),
          SizedBox(height: 20),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipOval(
                child: Image.network(Images.img5, height: 78, width: 78),
              ),
              SizedBox(height: 10),
              Text(
                "Amara Jones",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Plus Jakarta sans",
                  color: Color(0xFFE8E8E8),
                ),
              ),
            ],
          ),
          SizedBox(height: 36),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Personal info",
                  style: TextStyle(
                    fontFamily: "Plus Jakarta Sans",
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Color(0xFF7B8A99),
                  ),
                ),

                SizedBox(width: 11),

                Expanded(
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
          ),
          
          ProfileInfo(icon: Icons.edit, name: "Edit Profile", arrowIcon: Icons.arrow_forward_ios,editGradient: LinearGradient(colors: [
                  Color(0xFFF23943),
                  Color(0xFFC1232C)
                ]),),
                ProfileInfo(icon: Icons.diamond, name: "Profile", arrowIcon: Icons.arrow_forward_ios,),
                ProfileInfo(icon: Icons.diamond, name: "My Quotese", arrowIcon: Icons.arrow_forward_ios),
                ProfileInfo(icon: Icons.diamond, name: "Upgrade to Pro", arrowIcon: Icons.arrow_forward_ios),
                ProfileInfo(icon: Icons.delete, name: "Delete my account", arrowIcon: Icons.arrow_forward_ios),
                ProfileInfo(icon: Icons.logout_rounded, name: "Log out", arrowIcon: Icons.arrow_forward_ios,isLast: true,)
        ],
      ),
    );
  }
}
