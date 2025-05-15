import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sports_app/services/profile_details.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditProfileProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool _hasError = false;

  bool get isLoading => _isLoading;
  bool get hasError => _hasError;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setError(bool value) {
    _hasError = value;
    notifyListeners();
  }

  FocusNode? firstNameFocusNode;
  TextEditingController firstNameController = TextEditingController();
  String? validateFirstName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name cannot be empty';
    }
    return null;
  }

  FocusNode? lastNameFocusNode;
  TextEditingController? lastNameController = TextEditingController();
  String? validateLastName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Last Name cannot be empty';
    }
    return null;
  }

  FocusNode? emailFocusNode;
  TextEditingController emailTextController = TextEditingController();
  String emailRegex = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    } else if (!RegExp(emailRegex).hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  FocusNode? recurrenceNode;
  String? selectedGender;
  String? validateGender(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select a gender';
    }
    return null;
  }

  ProfileDetails? _profileDetails;

  ProfileDetails? get profileDetails => _profileDetails;

  set profileDetails(ProfileDetails? value) {
    _profileDetails = value;
    notifyListeners();
  }

  String? _profilePicture = '';

  String? get profilePicture => _profilePicture;

  set profilePicture(String? value) {
    _profilePicture = value;
    notifyListeners();
  }

  Future<void> updateUserProfile(
    String imageProfile,
    BuildContext context,
  ) async {
    String? userId = UserService().getCurrentUserId();
    if (userId != null) {
      DatabaseReference ref = FirebaseDatabase.instance.ref(
        'w02_users/$userId/profileDetails',
      );
      await ref.update({'imageProfile': imageProfile});
      profilePicture = imageProfile; // Update the provider's state immediately
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Image Uploaded successfully"),
          backgroundColor: Colors.grey,
        ),
      );
    } else {
      print('User is not authenticated');
    }
  }

  Future<String?> fetchUserProfileImage() async {
    String? userId = UserService().getCurrentUserId();
    if (userId != null) {
      DatabaseReference ref = FirebaseDatabase.instance.ref(
        'w02_users/$userId/profileDetails',
      );
      DatabaseEvent event =
          await ref.once(); // This now returns DatabaseEvent, not DataSnapshot.

      DataSnapshot snapshot = event.snapshot;

      final data = snapshot.value;
      if (data is! Map) {
        return 'Failed to fetch valid user details. Please try again.';
      }
      Map<String, dynamic> userData = Map<String, dynamic>.from(data);

      ProfileDetails profileDetails = ProfileDetails.fromMap(userData);

      profilePicture = profileDetails.imageProfile ?? '';
      emailTextController.text = profileDetails.email ?? '';

      // Extract profile details
      firstNameController.text = '${profileDetails.firstName}';
      notifyListeners();
      if (snapshot.exists) {
        // Fetch the 'imageProfile' from the snapshot
        log('imageProfile ->1 $profilePicture');

        return snapshot.child('imageProfile').value as String?;
      } else {
        print('User profile not found');
        return null;
      }
    } else {
      print('User is not authenticated');
      return null;
    }
  }

  Future<void> updateUserProfileDetails(BuildContext context) async {
    setLoading(true);

    try {
      String? userId = UserService().getCurrentUserId();
      if (userId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User is not authenticated')),
        );
        setLoading(false);
        return;
      }

      // Validate gender
      if (selectedGender == null || selectedGender!.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a gender'),
            backgroundColor: Colors.red,
          ),
        );
        setLoading(false);
        return;
      }

      // First fetch the existing profile details to get the current image
      DatabaseReference ref = FirebaseDatabase.instance.ref(
        'w02_users/$userId/profileDetails',
      );
      DatabaseEvent event = await ref.once();
      DataSnapshot snapshot = event.snapshot;

      String? existingImageProfile;
      if (snapshot.exists) {
        final data = snapshot.value;
        if (data is Map) {
          Map<String, dynamic> userData = Map<String, dynamic>.from(data);
          existingImageProfile = userData['imageProfile'] as String?;
        }
      }

      // Create the profile details object with the existing image OR the current provider image
      var profileDetails = ProfileDetails(
        firstName: firstNameController.text,
        lastName: lastNameController?.text ?? '',
        email: emailTextController.text,
        gender: selectedGender,
        imageProfile: existingImageProfile ?? profilePicture,
      );

      // Update the user's profile details in Firebase
      await ref.update(profileDetails.toMap());
      setLoading(false);

      // Return to the previous screen with a result of true
      Navigator.pop(context, true);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile updated successfully'),
          backgroundColor: Colors.grey,
        ),
      );
    } catch (e) {
      setLoading(false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  Future<ProfileDetails?> fetchUserProfileDetails() async {
    try {
      setLoading(true);
      setError(false);

      // Get current user ID
      String? userId = UserService().getCurrentUserId();
      if (userId == null) {
        log('User is not authenticated');
        setLoading(false);
        setError(true);
        return null;
      }

      // Get reference and fetch data
      DatabaseReference ref = FirebaseDatabase.instance.ref(
        'w02_users/$userId/profileDetails',
      );
      final event = await ref.once();
      final snapshot = event.snapshot;

      if (!snapshot.exists) {
        log('No profile data found');
        setLoading(false);
        setError(true);
        return null;
      }

      // Parse data
      final data = snapshot.value;
      if (data == null || data is! Map) {
        log('Invalid data format');
        setLoading(false);
        setError(true);
        return null;
      }

      // Convert and update UI
      Map<String, dynamic> userData = Map<String, dynamic>.from(data);
      profileDetails = ProfileDetails.fromMap(userData);

      // Update controllers
      firstNameController.text = profileDetails?.firstName ?? '';
      lastNameController?.text = profileDetails?.lastName ?? '';
      emailTextController.text = profileDetails?.email ?? '';
      profilePicture = profileDetails?.imageProfile;

      // Handle gender with proper null check
      String? gender = profileDetails?.gender;
      selectedGender = (gender != null && gender.isNotEmpty) ? gender : null;

      setLoading(false);
      return profileDetails;
    } catch (e) {
      log('Error fetching profile details: $e');
      setLoading(false);
      setError(true);
      return null;
    }
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    // Optionally clear provider state
    profileDetails = null;
    profilePicture = '';
    firstNameController.clear();
    lastNameController?.clear();
    emailTextController.clear();
    selectedGender = null;
    notifyListeners();
    // Navigate to login/signup
    Navigator.pushNamedAndRemoveUntil(context, '/sign_in', (route) => false);
  }

  /// Update only the user's name and email (no gender required)
  Future<void> updateUserNameAndEmail(
    String name,
    String email,
    BuildContext context,
  ) async {
    setLoading(true);
    try {
      String? userId = UserService().getCurrentUserId();
      if (userId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User is not authenticated')),
        );
        setLoading(false);
        return;
      }
      DatabaseReference ref = FirebaseDatabase.instance.ref(
        'w02_users/$userId/profileDetails',
      );
      await ref.update({'firstName': name, 'email': email});
      // Update provider state
      firstNameController.text = name;
      emailTextController.text = email;
      if (_profileDetails != null) {
        _profileDetails!.firstName = name;
        _profileDetails!.email = email;
      }
      notifyListeners();
      setLoading(false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile updated successfully'),
          backgroundColor: Colors.grey,
        ),
      );
    } catch (e) {
      setLoading(false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  void dispose() {
    // Clean up controllers
    firstNameController.dispose();
    lastNameController?.dispose();
    emailTextController.dispose();
    super.dispose();
  }
}


// import 'dart:developer';

// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:sports_app/services/profile_details.dart';



// class EditProfileProvider extends ChangeNotifier {
//   bool _isLoading = false;
//   bool _hasError = false;

//   bool get isLoading => _isLoading;
//   bool get hasError => _hasError;

//   void setLoading(bool value) {
//     _isLoading = value;
//     notifyListeners();
//   }

//   void setError(bool value) {
//     _hasError = value;
//     notifyListeners();
//   }

//   FocusNode? firstNameFocusNode;
//   TextEditingController firstNameController = TextEditingController();
//   String? validateFirstName(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Name cannot be empty';
//     }
//     return null;
//   }

//   FocusNode? lastNameFocusNode;
//   TextEditingController? lastNameController = TextEditingController();
//   String? validateLastName(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Last Name cannot be empty';
//     }
//     return null;
//   }

//   FocusNode? emailFocusNode;
//   TextEditingController emailTextController = TextEditingController();
//   String emailRegex = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';

//   String? validateEmail(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Email cannot be empty';
//     } else if (!RegExp(emailRegex).hasMatch(value)) {
//       return 'Please enter a valid email address';
//     }
//     return null;
//   }

//   FocusNode? recurrenceNode;
//   String? selectedGender;
//   String? validateGender(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please select a gender';
//     }
//     return null;
//   }

//   ProfileDetails? _profileDetails;

//   ProfileDetails? get profileDetails => _profileDetails;

//   set profileDetails(ProfileDetails? value) {
//     _profileDetails = value;
//     notifyListeners();
//   }

//   String? _profilePicture = '';

//   String? get profilePicture => _profilePicture;

//   set profilePicture(String? value) {
//     _profilePicture = value;
//     notifyListeners();
//   }

//   Future<void> updateUserProfile(
//       String imageProfile, BuildContext context) async {
//     String? userId = UserService().getCurrentUserId();
//     if (userId != null) {
//       DatabaseReference ref =
//           FirebaseDatabase.instance.ref('w02_users/$userId/profileDetails');
//       await ref.update({
//         'imageProfile': imageProfile,
//       });
//       profilePicture = await fetchUserProfileImage();
//       notifyListeners();
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//             content: Text("Image Uploaded successfully"),
//             backgroundColor: Colors.grey),
//       );
//     } else {
//       print('User is not authenticated');
//     }
//   }

//   Future<String?> fetchUserProfileImage() async {
//     String? userId = UserService().getCurrentUserId();
//     if (userId != null) {
//       DatabaseReference ref =
//           FirebaseDatabase.instance.ref('w02_users/$userId/profileDetails');
//       DatabaseEvent event =
//           await ref.once(); // This now returns DatabaseEvent, not DataSnapshot.

//       DataSnapshot snapshot = event.snapshot;

//       final data = snapshot.value;
//       if (data is! Map) {
//         return 'Failed to fetch valid user details. Please try again.';
//       }
//       Map<String, dynamic> userData = Map<String, dynamic>.from(data);

//       ProfileDetails profileDetails = ProfileDetails.fromMap(userData);

//       profilePicture = profileDetails.imageProfile ?? '';
//       emailTextController.text = profileDetails.email ?? '';

//       // Extract profile details
//       firstNameController.text = '${profileDetails.firstName}';
//       notifyListeners();
//       if (snapshot.exists) {
//         // Fetch the 'imageProfile' from the snapshot
//         log('imageProfile ->1 $profilePicture');

//         return snapshot.child('imageProfile').value as String?;
//       } else {
//         print('User profile not found');
//         return null;
//       }
//     } else {
//       print('User is not authenticated');
//       return null;
//     }
//   }

//   Future<void> updateUserProfileDetails(BuildContext context) async {
//     setLoading(true);

//     try {
//       String? userId = UserService().getCurrentUserId();
//       if (userId == null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('User is not authenticated')),
//         );
//         setLoading(false);
//         return;
//       }

//       // Validate gender
//       if (selectedGender == null || selectedGender!.isEmpty) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Please select a gender'),
//             backgroundColor: Colors.red,
//           ),
//         );
//         setLoading(false);
//         return;
//       }

//       // First fetch the existing profile details to get the current image
//       DatabaseReference ref =
//           FirebaseDatabase.instance.ref('w02_users/$userId/profileDetails');
//       DatabaseEvent event = await ref.once();
//       DataSnapshot snapshot = event.snapshot;

//       String? existingImageProfile;
//       if (snapshot.exists) {
//         final data = snapshot.value;
//         if (data is Map) {
//           Map<String, dynamic> userData = Map<String, dynamic>.from(data);
//           existingImageProfile = userData['imageProfile'] as String?;
//         }
//       }

//       // Create the profile details object with the existing image
//       var profileDetails = ProfileDetails(
//         firstName: firstNameController.text,
//         lastName: lastNameController?.text ?? '',
//         email: emailTextController.text,
//         gender: selectedGender,
//         imageProfile: existingImageProfile ?? profilePicture,
//       );

//       // Update the user's profile details in Firebase
//       await ref.update(profileDetails.toMap());
//       setLoading(false);

//       // Return to the previous screen with a result of true
//       Navigator.pop(context, true);

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//             content: Text('Profile updated successfully'),
//             backgroundColor: Colors.grey),
//       );
//     } catch (e) {
//       setLoading(false);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e')),
//       );
//     }
//   }

//   Future<ProfileDetails?> fetchUserProfileDetails() async {
//     try {
//       setLoading(true);
//       setError(false);

//       // Get current user ID
//       String? userId = UserService().getCurrentUserId();
//       if (userId == null) {
//         log('User is not authenticated');
//         setLoading(false);
//         setError(true);
//         return null;
//       }

//       // Get reference and fetch data
//       DatabaseReference ref =
//           FirebaseDatabase.instance.ref('w02_users/$userId/profileDetails');
//       final event = await ref.once();
//       final snapshot = event.snapshot;

//       if (!snapshot.exists) {
//         log('No profile data found');
//         setLoading(false);
//         setError(true);
//         return null;
//       }

//       // Parse data
//       final data = snapshot.value;
//       if (data == null || data is! Map) {
//         log('Invalid data format');
//         setLoading(false);
//         setError(true);
//         return null;
//       }

//       // Convert and update UI
//       Map<String, dynamic> userData = Map<String, dynamic>.from(data);
//       profileDetails = ProfileDetails.fromMap(userData);

//       // Update controllers
//       firstNameController.text = profileDetails?.firstName ?? '';
//       lastNameController?.text = profileDetails?.lastName ?? '';
//       emailTextController.text = profileDetails?.email ?? '';
//       profilePicture = profileDetails?.imageProfile;

//       // Handle gender with proper null check
//       String? gender = profileDetails?.gender;
//       selectedGender = (gender != null && gender.isNotEmpty) ? gender : null;

//       setLoading(false);
//       return profileDetails;
//     } catch (e) {
//       log('Error fetching profile details: $e');
//       setLoading(false);
//       setError(true);
//       return null;
//     }
//   }

//   @override
//   void dispose() {
//     // Clean up controllers
//     firstNameController.dispose();
//     lastNameController?.dispose();
//     emailTextController.dispose();
//     super.dispose();
//   }
// }