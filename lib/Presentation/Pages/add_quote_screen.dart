import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sports_app/Presentation/Views/sports_category_view.dart';
import 'package:sports_app/Presentation/Widgets/signin_page_buttons.dart';
import 'package:sports_app/Presentation/Widgets/skip_butoon.dart';

class AddQuoteScreen extends StatefulWidget {
  const AddQuoteScreen({super.key});

  @override
  State<AddQuoteScreen> createState() => _AddQuoteScreenState();
}

class _AddQuoteScreenState extends State<AddQuoteScreen> {
  final TextEditingController _quoteController = TextEditingController();
  BoxShadow boxShadow1 = BoxShadow(
  color:  Colors.black.withAlpha(25), 
  offset: const Offset(0, 1.42), 
  blurRadius: 3, 
  spreadRadius: 0, 
);

// Second Drop Shadow
BoxShadow boxShadow2 = BoxShadow(
  color: const Color(0xFF000000).withAlpha(10), 
  offset: Offset.zero, 
  blurRadius: 4, 
  spreadRadius: 0, 
);
  File? _imageFile;
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final PickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (PickedFile != null) {
      setState(() {
        _imageFile = File(PickedFile.path);
      });
    }
    // Implement your image picking logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF101922),
      body: SingleChildScrollView(
        child: Column(
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
                    "Add Quote",
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
            SizedBox(height: 19),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Write Quote",
                style: TextStyle(
                  fontFamily: "Open Sans",
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(
                    0xFF1E2730,
                  ).withAlpha(128), // Container background
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Color(0xFF1E2730), // Border color
                    width: 1, // Border width
                  ),
                ),
                child: TextField(
                  controller: _quoteController,
                  cursorColor: Colors.white, // Cursor color

                  maxLines: null, // Allow multiple lines (wraps automatically)
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 11,
                    ).copyWith(
                      top: 16,
                      bottom: 71,
                    ), // Padding inside the TextField
                    hintText: 'Enter your quote here',
                    hintStyle: TextStyle(color: Color(0xFF7B8A99)),
                    border: InputBorder.none, // No inner border
                    isCollapsed: true, // Reduce internal padding
                  ),
                  style: const TextStyle(
                    color: Color(0xFF7B8A99),
                    fontSize: 16,
                    fontFamily: "Open Sans",
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Choose your category",
                style: TextStyle(
                  fontFamily: "Open Sans",
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ).copyWith(top: 18),
              child: SportsCategoryView(),
            ),
            SizedBox(height: 28),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Background image",
                style: TextStyle(
                  fontFamily: "Open Sans",
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFE8E8E8),
                ),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: double.infinity,
                height: 148,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E2730),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white24),
                ),
                child:
                    _imageFile == null
                        ? Center(
                          child: GestureDetector(
                            onTap: _pickImage,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFFAFBFC),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 11,vertical: 11),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.cloud_upload, color: Color(0xFF121212)),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Upload Image',
                                      style: TextStyle(
                                        color: Color(0xFF121212),
                                        fontWeight: FontWeight.w600
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                        : ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            _imageFile!,
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
              ),
            ),
            SizedBox(height: 28),
            Center(child: Text("Or", style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w700,fontSize: 16,color: Color(0xFF7B8A99)),)),
            SizedBox(height: 28),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text("Select Cover Theme",style: TextStyle(fontFamily: "Open Sans", fontSize:16,fontWeight: FontWeight.w700,color: Color(0xFFE8E8E8) ),),
            )  ,
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                

                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                     height: 50,
                     width: 50,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Color(0xFF000000),width: 1),
                      gradient: LinearGradient(
                        colors: [Color(0xFF9F0FF7), Color(0xFF355EEF)],
                      ),
                    )),
                    Container(
                      height: 50,
                      width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Color(0xFFFFFFFF),width: 1.5),
                      gradient: LinearGradient(
                        colors: [Color(0xFFFC5000), Color(0xFF9F0FF7)],
                      ),
                    )),
                    Container(
                       height: 50,
                       width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      
                      gradient: LinearGradient(
                        colors: [Color(0xFFFC5000), Color(0xFF160FF7)],
                      ),
                    )),
                    Container(
                       height: 50,
                        width: 50,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      
                      gradient: LinearGradient(
                        colors: [Color(0xFFFCBD00), Color(0xFF9F0FF7)],
                      )
                    )),
                    Container(
                       height: 50,
                       width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      
                      gradient: LinearGradient(
                        colors: [Color(0xFF1E2730), Color(0xFF31404F)],
                      ),
                    ))

                ],
              )),
              SizedBox(height: 167),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13),
                child: SigninPageButtons(buttonText: "Add", onpressed: (){}),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13),
                child: SkipButoon(buttonText: "Cancel", onpressed: (){}),
              )
          ],
        ),
      ),
    );
  }
}
