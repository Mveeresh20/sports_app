import 'package:firebase_auth/firebase_auth.dart';


class ProfileDetails {
  String? firstName;
  String? lastName;
  String? email;
  String? gender;
  String? imageProfile;

  ProfileDetails({
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.imageProfile,
  });

 
  ProfileDetails.fromMap(Map<String, dynamic> map) {
    firstName = map['firstName'];
    lastName = map['lastName'];
    email = map['email'];
    gender = map['gender'];
    imageProfile = map['imageProfile'];
  }

 
  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'gender': gender,
      'imageProfile': imageProfile,
    };
  }
}

// 2. UserService Class
class UserService {
  // Method to get the current user's ID
  String? getCurrentUserId() {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }

  
}
