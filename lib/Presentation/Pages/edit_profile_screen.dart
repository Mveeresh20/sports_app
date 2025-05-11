import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sports_app/Utils/Constants/images.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  @override
  File? _imageFile;
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
    // Implement your image picking logic here
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF101922),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                  "Edit Profile",
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
          SizedBox(height: 32),
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: Center(
                  child: Container(
                    
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white,width: 1)
                    ),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage:
                          _imageFile != null
                              ? FileImage(_imageFile!) as ImageProvider
                              : AssetImage(Images.img1),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: -15,
                right:
                    MediaQuery.of(context).size.width / 2 -
                    60 +
                    40, // align based on avatar radius
                child: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black54,
                  ),
                  child: Icon(Icons.camera_alt, color: Colors.white, size: 20),
                ),
              ),
            ],
          ),
          SizedBox(height: 28),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Container(
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
            

          ),
          SizedBox(height: 18),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Display name",style: TextStyle(fontFamily: "Plus Jakarta Sans", fontWeight: FontWeight.w600,fontSize: 16,color: Colors.white),),
                    Icon(Icons.edit,color: Color(0xFF7B8A99),size: 18,)
                  ],
            
                ),
                SizedBox(height: 9,),
                
            Container(
              decoration: BoxDecoration(
                color: const Color(
                  0xFF1E2730,
                ).withAlpha(128), // Container background
                borderRadius: BorderRadius.circular(8),
               
              ),
              child: TextField(
                controller: _nameController,
                cursorColor: Colors.white, // Cursor color
            
                maxLines: null, // Allow multiple lines (wraps automatically)
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 11,vertical: 10
                  ),
                   // Padding inside the TextField
                  hintText: 'Edi your name',
                  hintStyle: TextStyle(color: Color(0xFF7B8A99)),
                  border: InputBorder.none, 
                  isCollapsed: true, 
                ),
                style: const TextStyle(
                  color: Colors.white,
                  
                  fontSize: 16,
                  fontFamily: "Plus Jakarta Sans",
                ),
              ),
            ),
            SizedBox(height: 18,),
             Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Email",style: TextStyle(fontFamily: "Plus Jakarta Sans", fontWeight: FontWeight.w600,fontSize: 16,color: Colors.white),),
                    Icon(Icons.edit,color: Color(0xFF7B8A99),size: 18,)
                  ],
            
                ),
                SizedBox(height: 18,),
                Container(
              decoration: BoxDecoration(
                color: const Color(
                  0xFF1E2730,
                ).withAlpha(128), // Container background
                borderRadius: BorderRadius.circular(8),
               
              ),
              child: TextField(
                controller: _emailController,
                cursorColor: Colors.white, // Cursor color
            
                maxLines: null, // Allow multiple lines (wraps automatically)
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 11,vertical: 10
                  ),
                   // Padding inside the TextField
                  hintText: 'Edi your Email',
                  hintStyle: TextStyle(color: Color(0xFF7B8A99)),
                  border: InputBorder.none, 
                  isCollapsed: true, 
                ),
                style: const TextStyle(
                  color: Colors.white,
                  
                  fontSize: 16,
                  fontFamily: "Plus Jakarta Sans",
                ),
              ),
            ),


                ],
            
            ),
          )
        ],
      ),
    );
  }
}
