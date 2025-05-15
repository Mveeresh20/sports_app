import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sports_app/Utils/Constants/images.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sports_app/services/edit_profile_provider.dart';
import 'package:sports_app/services/image_picker_util.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  File? _imageFile;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Add form key

  late final EditProfileProvider _provider;

  @override
  void initState() {
    super.initState();
    _provider = Provider.of<EditProfileProvider>(context, listen: false);
    _initializeData();
  }

  Future<void> _initializeData() async {
    await _provider.fetchUserProfileDetails();
    // Initialize the controllers with data from the provider.  This is CRUCIAL
    _nameController.text = _provider.firstNameController.text;
    _emailController.text = _provider.emailTextController.text;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101922),
      body: Consumer<EditProfileProvider>(
        builder: (context, provider, child) {
          return buildScaffold(context, provider);
        },
      ),
    );
  }

  Widget buildScaffold(BuildContext context, EditProfileProvider provider) {
    return Scaffold(
      backgroundColor: const Color(0xFF101922),
      body:
          provider.isLoading
              ? const Center(
                child: CircularProgressIndicator(color: Colors.green),
              )
              : Form(
                //Wrap the whole body in a form
                key: _formKey,
                child: SingleChildScrollView(
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
                            IconButton(
                              icon: const Icon(
                                Icons.arrow_back_ios_new_outlined,
                                color: Colors.white,
                                size: 16,
                              ),
                              onPressed: () {
                                Navigator.pop(
                                  context,
                                  true,
                                ); //important:  Return true to indicate profile was updated
                              },
                            ),
                            const SizedBox(
                              width: 80,
                            ), //adjust spacing as needed
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
                      const SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Color(0xFF27313B),
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              ImagePickerUtil().showImageSourceSelection(
                                context,
                                (responseBody) async {
                                  print("Upload Success: $responseBody");
                                  await provider.updateUserProfile(
                                    responseBody,
                                    context,
                                  );
                                  setState(() {
                                    _imageFile = File(responseBody);
                                  });
                                },
                                (error) {
                                  print("Upload Failed: $error");
                                },
                              );
                            },
                            child: Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1,
                                  ),
                                ),
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundImage:
                                      provider.profilePicture != null &&
                                              provider
                                                  .profilePicture!
                                                  .isNotEmpty
                                          ? CachedNetworkImageProvider(
                                            ImagePickerUtil()
                                                .getUrlForUserUploadedImage(
                                                  provider.profilePicture!,
                                                ),
                                          )
                                          : NetworkImage(Images.img1)
                                              as ImageProvider,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: -15,
                            right:
                                MediaQuery.of(context).size.width / 2 - 60 + 40,
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black54,
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 28),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color(0xFF27313B),
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Display name",
                                  style: TextStyle(
                                    fontFamily: "Plus Jakarta Sans",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // You can add logic here to navigate to a dedicated name edit screen if you want
                                    // For now,  keep it simple
                                  },
                                  child: const Icon(
                                    Icons.edit,
                                    color: Color(0xFF7B8A99),
                                    size: 18,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 9),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF1E2730).withAlpha(128),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: TextFormField(
                                controller: _nameController,
                                cursorColor: Colors.white,
                                maxLines: null,
                                keyboardType: TextInputType.multiline,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 11,
                                    vertical: 10,
                                  ),
                                  hintText: 'Edit your name',
                                  hintStyle: TextStyle(
                                    color: Color(0xFF7B8A99),
                                  ),
                                  border: InputBorder.none,
                                  isCollapsed: true,
                                ),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: "Plus Jakarta Sans",
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your name'; // Basic validation
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 18),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Email",
                                  style: TextStyle(
                                    fontFamily: "Plus Jakarta Sans",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // same here
                                  },
                                  child: const Icon(
                                    Icons.edit,
                                    color: Color(0xFF7B8A99),
                                    size: 18,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 18),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF1E2730).withAlpha(128),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: TextFormField(
                                controller: _emailController,
                                cursorColor: Colors.white,
                                maxLines: null,
                                keyboardType: TextInputType.multiline,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 11,
                                    vertical: 10,
                                  ),
                                  hintText: 'Edit your Email',
                                  hintStyle: TextStyle(
                                    color: Color(0xFF7B8A99),
                                  ),
                                  border: InputBorder.none,
                                  isCollapsed: true,
                                ),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: "Plus Jakarta Sans",
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  // Basic email validation (you can use a better regex)
                                  if (!value.contains('@')) {
                                    return 'Invalid email address';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 24),
        child: SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF23943),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed:
                provider.isLoading
                    ? null
                    : () async {
                      if (_formKey.currentState!.validate()) {
                        await provider.updateUserNameAndEmail(
                          _nameController.text.trim(),
                          _emailController.text.trim(),
                          context,
                        );
                      }
                    },
            child:
                provider.isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                      'Save Changes',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
          ),
        ),
      ),
                    ],
                  ),
                ),
              ),
      // Add Save Changes button at the bottom
      
    );
  }
}



// import 'dart:io';
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:sports_app/Utils/Constants/images.dart';
// import 'package:provider/provider.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:sports_app/services/edit_profile_provider.dart';
// import 'package:sports_app/services/image_picker_util.dart';
// import 'dart:developer';




// class EditProfileScreen extends StatefulWidget {
//   const EditProfileScreen({super.key});

//   @override
//   State<EditProfileScreen> createState() => _EditProfileScreenState();
// }

// class _EditProfileScreenState extends State<EditProfileScreen> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   File? _imageFile;
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Add form key

//   late final EditProfileProvider _provider;

//   @override
//   void initState() {
//     super.initState();
//     _provider = EditProfileProvider();
//     _initializeData();
//   }

//   Future<void> _initializeData() async {
//     await _provider.fetchUserProfileDetails();
//     // Initialize the controllers with data from the provider.  This is CRUCIAL
//     _nameController.text = _provider.firstNameController.text;
//     _emailController.text = _provider.emailTextController.text;
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _provider.dispose();
//     super.dispose();
//   }

//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _imageFile = File(pickedFile.path);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<EditProfileProvider>.value(
//       value: _provider,
//       child: Consumer<EditProfileProvider>(
//         builder: (context, provider, child) {
//           return buildScaffold(context, provider);
//         },
//       ),
//     );
//   }

//   Widget buildScaffold(BuildContext context, EditProfileProvider provider) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF101922),
//       body: provider.isLoading // Show loader
//           ? const Center(child: CircularProgressIndicator(color: Colors.green))
//           : Form(  //Wrap the whole body in a form
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 20,
//                     ).copyWith(top: 64),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         IconButton(
//                           icon: const Icon(
//                             Icons.arrow_back_ios_new_outlined,
//                             color: Colors.white,
//                             size: 16,
//                           ),
//                           onPressed: () {
//                             Navigator.pop(
//                                 context,
//                                 true); //important:  Return true to indicate profile was updated
//                           },
//                         ),
//                         const SizedBox(width: 80), //adjust spacing as needed
//                         const Text(
//                           "Edit Profile",
//                           style: TextStyle(
//                             fontFamily: "Plus Jakarta Sans",
//                             fontSize: 18,
//                             fontWeight: FontWeight.w700,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   Container(
//                     width: double.infinity,
//                     decoration: const BoxDecoration(
//                       border: Border(
//                         bottom: BorderSide(
//                           color: Color(0xFF27313B),
//                           width: 1,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 32),
//                   Stack(
//                     clipBehavior: Clip.none,
//                     alignment: Alignment.center,
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           ImagePickerUtil().showImageSourceSelection(
//                             context,
//                             (responseBody) async {
//                               print("Upload Success: $responseBody" );
//                               await provider.updateUserProfile(
//                                   responseBody, context);
//                               setState(() {
//                                 _imageFile = File(responseBody);
//                               });
//                             },
//                             (error) {
//                               print("Upload Failed: $error");
//                             },
//                           );
//                         },
//                         child: Center(
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 border:
//                                     Border.all(color: Colors.white, width: 1)),
//                             child: CircleAvatar(
//                               radius: 60,
//                               backgroundImage:
//                                   provider.profilePicture != null &&
//                                           provider.profilePicture!.isNotEmpty
//                                       ? CachedNetworkImageProvider(
//                                           ImagePickerUtil()
//                                               .getUrlForUserUploadedImage(
//                                                   provider.profilePicture!))
//                                       as ImageProvider
//                                       : _imageFile != null
//                                           ? FileImage(_imageFile!)
//                                           : const AssetImage(Images.img1),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Positioned(
//                         bottom: -15,
//                         right: MediaQuery.of(context).size.width / 2 - 60 + 40,
//                         child: Container(
//                           padding: const EdgeInsets.all(6),
//                           decoration: const BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Colors.black54,
//                           ),
//                           child: const Icon(Icons.camera_alt,
//                               color: Colors.white, size: 20),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 28),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 25),
//                     child: Container(
//                       width: double.infinity,
//                       decoration: const BoxDecoration(
//                         border: Border(
//                           bottom: BorderSide(
//                             color: Color(0xFF27313B),
//                             width: 1,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 18),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 25),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             const Text(
//                               "Display name",
//                               style: TextStyle(
//                                   fontFamily: "Plus Jakarta Sans",
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 16,
//                                   color: Colors.white),
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 // You can add logic here to navigate to a dedicated name edit screen if you want
//                                 // For now,  keep it simple
//                               },
//                               child: const Icon(
//                                 Icons.edit,
//                                 color: Color(0xFF7B8A99),
//                                 size: 18,
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(
//                           height: 9,
//                         ),
//                         Container(
//                           decoration: BoxDecoration(
//                             color: const Color(0xFF1E2730).withAlpha(128),
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: TextFormField(
//                             controller: _nameController,
//                             cursorColor: Colors.white,
//                             maxLines:
//                                 null, // Allow multiple lines (wraps automatically)
//                             keyboardType: TextInputType.multiline,
//                             decoration: const InputDecoration(
//                               contentPadding: EdgeInsets.symmetric(
//                                   horizontal: 11, vertical: 10),
//                               hintText: 'Edit your name',
//                               hintStyle: TextStyle(color: Color(0xFF7B8A99)),
//                               border: InputBorder.none,
//                               isCollapsed: true,
//                             ),
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                               fontFamily: "Plus Jakarta Sans",
//                             ),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter your name'; // Basic validation
//                               }
//                               return null;
//                             },
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 18,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             const Text(
//                               "Email",
//                               style: TextStyle(
//                                   fontFamily: "Plus Jakarta Sans",
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 16,
//                                   color: Colors.white),
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 // same here
//                               },
//                               child: const Icon(
//                                 Icons.edit,
//                                 color: Color(0xFF7B8A99),
//                                 size: 18,
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(
//                           height: 18,
//                         ),
//                         Container(
//                           decoration: BoxDecoration(
//                             color: const Color(0xFF1E2730).withAlpha(128),
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: TextFormField(
//                             controller: _emailController,
//                             cursorColor: Colors.white,
//                             maxLines:
//                                 null, // Allow multiple lines (wraps automatically)
//                             keyboardType: TextInputType.multiline,
//                             decoration: const InputDecoration(
//                               contentPadding: EdgeInsets.symmetric(
//                                   horizontal: 11, vertical: 10),
//                               hintText: 'Edit your Email',
//                               hintStyle: TextStyle(color: Color(0xFF7B8A99)),
//                               border: InputBorder.none,
//                               isCollapsed: true,
//                             ),
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                               fontFamily: "Plus Jakarta Sans",
//                             ),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter your email';
//                               }
//                               // Basic email validation (you can use a better regex)
//                               if (!value.contains('@')) {
//                                 return 'Invalid email address';
//                               }
//                               return null;
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   // Padding(
//                   //   padding: const EdgeInsets.symmetric(horizontal: 25),
//                   //   child: ButtonComponent(
//                   //     colorBorder: colorGreen,
//                   //     isLoading: provider.isLoading,
//                   //     onPressed: () {
//                   //       if (_formKey.currentState?.validate() ??
//                   //           false) { // added form validation
//                   //         NetworkHelper.checkAndPerformAction(
//                   //           context,
//                   //           () async {
//                   //             if (SharedPrefe.isGuestLoginDone()) {
//                   //               ScaffoldMessenger.of(context).showSnackBar(
//                   //                 const SnackBar(
//                   //                     content: Text(
//                   //                         "You are logged in as a guest. Please log in to update your profile."),
//                   //                     backgroundColor: Colors.red),
//                   //               );
//                   //             } else {
//                   //               // Update user profile details.
//                   //               provider.firstNameController.text =
//                   //                   _nameController.text; //sync
//                   //               provider.emailTextController.text =
//                   //                   _emailController
//                   //                       .text; //important step to update the provider
//                   //               provider.updateUserProfileDetails(context);
//                   //             }
//                   //           },
//                   //         );
//                   //       }
//                   //     },
//                   //     text: "Edit Profile",
//                   //     buttonColor: colorGreen,
//                   //   ),
//                   // ),
//                   const SizedBox(height: 20),
//                 ],
//               ),
//             ),
//     );
//   }
// }





// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:sports_app/Utils/Constants/images.dart';

// class EditProfileScreen extends StatefulWidget {
//   const EditProfileScreen({super.key});

//   @override
//   State<EditProfileScreen> createState() => _EditProfileScreenState();
// }

// class _EditProfileScreenState extends State<EditProfileScreen> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   @override
//   File? _imageFile;
//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _imageFile = File(pickedFile.path);
//       });
//     }
//     // Implement your image picking logic here
//   }

//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFF101922),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(
//               horizontal: 20,
//             ).copyWith(top: 64),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 const Icon(
//                   Icons.arrow_back_ios_new_outlined,
//                   color: Colors.white,
//                   size: 16,
//                 ),
//                 const SizedBox(width: 117),
//                 const Text(
//                   "Edit Profile",
//                   style: TextStyle(
//                     fontFamily: "Plus Jakarta Sans",
//                     fontSize: 18,
//                     fontWeight: FontWeight.w700,
//                     color: Colors.white,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 16),
//           Container(
//             width: double.infinity,
//             decoration: BoxDecoration(
//               border: Border(
//                 bottom: BorderSide(
//                   color: Color(0xFF27313B),
//                   width: 1,
//                 ), // Only bottom border with 1px width
//               ),
//             ),
//           ),
//           SizedBox(height: 32),
//           Stack(
//             clipBehavior: Clip.none,
//             alignment: Alignment.center,
//             children: [
//               GestureDetector(
//                 onTap: _pickImage,
//                 child: Center(
//                   child: Container(
                    
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border: Border.all(color: Colors.white,width: 1)
//                     ),
//                     child: CircleAvatar(
//                       radius: 60,
//                       backgroundImage:
//                           _imageFile != null
//                               ? FileImage(_imageFile!) as ImageProvider
//                               : AssetImage(Images.img1),
//                     ),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 bottom: -15,
//                 right:
//                     MediaQuery.of(context).size.width / 2 -
//                     60 +
//                     40, // align based on avatar radius
//                 child: Container(
//                   padding: EdgeInsets.all(6),
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Colors.black54,
//                   ),
//                   child: Icon(Icons.camera_alt, color: Colors.white, size: 20),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 28),
          
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 25),
//             child: Container(
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 border: Border(
//                   bottom: BorderSide(
//                     color: Color(0xFF27313B),
//                     width: 1,
//                   ), // Only bottom border with 1px width
//                 ),
//               ),
//             ),
            

//           ),
//           SizedBox(height: 18),
          
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 25),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text("Display name",style: TextStyle(fontFamily: "Plus Jakarta Sans", fontWeight: FontWeight.w600,fontSize: 16,color: Colors.white),),
//                     Icon(Icons.edit,color: Color(0xFF7B8A99),size: 18,)
//                   ],
            
//                 ),
//                 SizedBox(height: 9,),
                
//             Container(
//               decoration: BoxDecoration(
//                 color: const Color(
//                   0xFF1E2730,
//                 ).withAlpha(128), // Container background
//                 borderRadius: BorderRadius.circular(8),
               
//               ),
//               child: TextField(
//                 controller: _nameController,
//                 cursorColor: Colors.white, // Cursor color
            
//                 maxLines: null, // Allow multiple lines (wraps automatically)
//                 keyboardType: TextInputType.multiline,
//                 decoration: InputDecoration(
//                   contentPadding: const EdgeInsets.symmetric(
//                     horizontal: 11,vertical: 10
//                   ),
//                    // Padding inside the TextField
//                   hintText: 'Edi your name',
//                   hintStyle: TextStyle(color: Color(0xFF7B8A99)),
//                   border: InputBorder.none, 
//                   isCollapsed: true, 
//                 ),
//                 style: const TextStyle(
//                   color: Colors.white,
                  
//                   fontSize: 16,
//                   fontFamily: "Plus Jakarta Sans",
//                 ),
//               ),
//             ),
//             SizedBox(height: 18,),
//              Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text("Email",style: TextStyle(fontFamily: "Plus Jakarta Sans", fontWeight: FontWeight.w600,fontSize: 16,color: Colors.white),),
//                     Icon(Icons.edit,color: Color(0xFF7B8A99),size: 18,)
//                   ],
            
//                 ),
//                 SizedBox(height: 18,),
//                 Container(
//               decoration: BoxDecoration(
//                 color: const Color(
//                   0xFF1E2730,
//                 ).withAlpha(128), // Container background
//                 borderRadius: BorderRadius.circular(8),
               
//               ),
//               child: TextField(
//                 controller: _emailController,
//                 cursorColor: Colors.white, // Cursor color
            
//                 maxLines: null, // Allow multiple lines (wraps automatically)
//                 keyboardType: TextInputType.multiline,
//                 decoration: InputDecoration(
//                   contentPadding: const EdgeInsets.symmetric(
//                     horizontal: 11,vertical: 10
//                   ),
//                    // Padding inside the TextField
//                   hintText: 'Edi your Email',
//                   hintStyle: TextStyle(color: Color(0xFF7B8A99)),
//                   border: InputBorder.none, 
//                   isCollapsed: true, 
//                 ),
//                 style: const TextStyle(
//                   color: Colors.white,
                  
//                   fontSize: 16,
//                   fontFamily: "Plus Jakarta Sans",
//                 ),
//               ),
//             ),


//                 ],
            
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
