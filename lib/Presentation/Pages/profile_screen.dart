import 'package:flutter/material.dart';
import 'package:sports_app/Presentation/Pages/edit_profile_screen.dart';
import 'package:sports_app/Presentation/Pages/my_quotes.dart';
import 'package:sports_app/Presentation/Pages/premium_purchase.dart';
import 'package:sports_app/Presentation/Pages/progress.dart';
import 'package:sports_app/Presentation/Pages/saved_quotes.dart';
import 'package:sports_app/Presentation/Pages/sign_up.dart';
import 'package:sports_app/Presentation/Pages/sign_in.dart';
import 'package:sports_app/Presentation/Views/profile_info.dart';
import 'package:sports_app/Utils/Constants/images.dart';
import 'package:provider/provider.dart'; // Import provider
import 'package:sports_app/services/edit_profile_provider.dart'; // Import your provider
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sports_app/services/image_picker_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () =>
          Provider.of<EditProfileProvider>(
            context,
            listen: false,
          ).fetchUserProfileDetails(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<EditProfileProvider>(context);
    final userName = profileProvider.profileDetails?.firstName ?? "User";
    final userImage = profileProvider.profilePicture;

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
                child: SizedBox(
                  height: 78,
                  width: 78,
                  child:
                      userImage != null && userImage.isNotEmpty
                          ? CachedNetworkImage(
                            imageUrl: ImagePickerUtil()
                                .getUrlForUserUploadedImage(userImage),
                            fit: BoxFit.cover,
                            placeholder:
                                (context, url) => CircularProgressIndicator(),
                            errorWidget:
                                (context, url, error) => Image.network(
                                  Images.img5,
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (context, error, stackTrace) =>
                                          Icon(Icons.person),
                                ),
                          )
                          : Image.network(
                            Images.img5,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (context, error, stackTrace) =>
                                    Icon(Icons.person),
                          ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                userName,
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
          ProfileInfo(
            icon: Icons.edit,
            name: "Edit Profile",
            arrowIcon: Icons.arrow_forward_ios,
            editGradient: LinearGradient(
              colors: [Color(0xFFF23943), Color(0xFFC1232C)],
            ),
            onClick: () async {
              // Use push and wait for the result
              final updated = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditProfileScreen()),
              );
              // You can optionally do something if the profile was updated
              if (updated == true) {
                // Optionally reload data or show a confirmation message
                print("Profile updated!");
              }
            },
          ),
          ProfileInfo(
            icon: Icons.diamond,
            name: "Progress",
            arrowIcon: Icons.arrow_forward_ios,
            onClick: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Progress()),
              );
            },
          ),
          ProfileInfo(
            icon: Icons.diamond,
            name: "My Quotese",
            arrowIcon: Icons.arrow_forward_ios,
            onClick: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyQuotes()),
              );
            },
          ),
          ProfileInfo(
            icon: Icons.diamond,
            name: "Upgrade to Pro",
            arrowIcon: Icons.arrow_forward_ios,
            onClick: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PremiumPurchase()),
              );
            },
          ),
          ProfileInfo(
            icon: Icons.delete,
            name: "Delete my account",
            arrowIcon: Icons.arrow_forward_ios,
            onClick: () {
              showDeleteAccountDialog(context);
            },
          ),
          ProfileInfo(
            icon: Icons.logout_rounded,
            name: "Log out",
            arrowIcon: Icons.arrow_forward_ios,
            isLast: true,
            onClick: () {
              showLogoutDialog(context);
            },
          ),
        ],
      ),
    );
  }
}

void showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder:
        (context) => Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: 270,
              height: 122.5,
              decoration: BoxDecoration(
                color: const Color(0xFF1E2730),
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.18),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Title and subtitle
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 18,
                      left: 16,
                      right: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 238,
                          child: Text(
                            "Logout",
                            style: const TextStyle(
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                              height: 22 / 17,
                              letterSpacing: -0.41,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 2),
                        SizedBox(
                          width: 238,
                          child: Text(
                            "are you sure you want to log out?",
                            style: const TextStyle(
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                              height: 18 / 13,
                              letterSpacing: -0.08,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  // Buttons
                  Row(
                    children: [
                      // Not Now
                      SizedBox(
                        width: 134.75,
                        height: 44,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              vertical: 11,
                              horizontal: 8,
                            ),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(14),
                              ),
                            ),
                            foregroundColor: const Color(0xFF007AFF),
                            backgroundColor: Colors.transparent,
                            textStyle: const TextStyle(
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w400,
                              fontSize: 17,
                              letterSpacing: -0.41,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("Not Now"),
                        ),
                      ),
                      // Yes
                      SizedBox(
                        width: 134.75,
                        height: 44,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              vertical: 11,
                              horizontal: 8,
                            ),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(14),
                              ),
                            ),
                            foregroundColor: const Color(0xFFF23943),
                            backgroundColor: Colors.transparent,
                            textStyle: const TextStyle(
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w400,
                              fontSize: 17,
                              letterSpacing: -0.41,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (_) => const SignIn()),
                              (route) => false,
                            );
                          },
                          child: const Text("Yes"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
  );
}

void showDeleteAccountDialog(BuildContext context) {
  final TextEditingController passwordController = TextEditingController();
  bool showPasswordField = false;
  bool isLoading = false;
  String? errorText;

  void deleteAccount() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      // Remove user data from Realtime Database
      final userId = user.uid;
      await FirebaseDatabase.instance.ref('w02_users/$userId').remove();
      // Delete user from Auth
      await user.delete();
      Navigator.of(context).pop();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const SignIn()),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        // Show password field for re-authentication
        showPasswordField = true;
        errorText = "Please re-enter your password to delete your account.";
      } else {
        errorText = e.message;
      }
      (context as Element).markNeedsBuild();
    } catch (e) {
      errorText = e.toString();
      (context as Element).markNeedsBuild();
    }
  }

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return StatefulBuilder(
        builder:
            (context, setState) => Center(
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: 270,
                  height: showPasswordField ? 210 : 140.5,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E2730),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.18),
                        blurRadius: 24,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Title and subtitle
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 18,
                          left: 16,
                          right: 16,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 238,
                              child: Text(
                                "Delete Account",
                                style: const TextStyle(
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17,
                                  height: 22 / 17,
                                  letterSpacing: -0.41,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 2),
                            SizedBox(
                              width: 238,
                              child: Text(
                                "are you sure you want to delete your account?",
                                style: const TextStyle(
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                  height: 18 / 13,
                                  letterSpacing: -0.08,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            if (showPasswordField) ...[
                              const SizedBox(height: 12),
                              TextField(
                                controller: passwordController,
                                obscureText: true,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: "Enter your password",
                                  hintStyle: const TextStyle(
                                    color: Colors.white54,
                                  ),
                                  filled: true,
                                  fillColor: const Color(0xFF232B34),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                ),
                              ),
                            ],
                            if (errorText != null) ...[
                              const SizedBox(height: 8),
                              Text(
                                errorText!,
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      const Spacer(),
                      // Buttons
                      Row(
                        children: [
                          // Not Now
                          SizedBox(
                            width: 134.75,
                            height: 44,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 11,
                                  horizontal: 8,
                                ),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(14),
                                  ),
                                ),
                                foregroundColor: const Color(0xFF007AFF),
                                backgroundColor: Colors.transparent,
                                textStyle: const TextStyle(
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 17,
                                  letterSpacing: -0.41,
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("Not Now"),
                            ),
                          ),
                          // Yes
                          SizedBox(
                            width: 134.75,
                            height: 44,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 11,
                                  horizontal: 8,
                                ),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(14),
                                  ),
                                ),
                                foregroundColor: const Color(0xFFF23943),
                                backgroundColor: Colors.transparent,
                                textStyle: const TextStyle(
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 17,
                                  letterSpacing: -0.41,
                                ),
                              ),
                              onPressed: () async {
                                if (showPasswordField) {
                                  setState(() => isLoading = true);
                                  try {
                                    final user =
                                        FirebaseAuth.instance.currentUser;
                                    final email = user?.email;
                                    final cred = EmailAuthProvider.credential(
                                      email: email!,
                                      password: passwordController.text,
                                    );
                                    await user!.reauthenticateWithCredential(
                                      cred,
                                    );
                                    setState(() {
                                      showPasswordField = false;
                                      errorText = null;
                                    });
                                    deleteAccount();
                                  } on FirebaseAuthException catch (e) {
                                    setState(() {
                                      errorText =
                                          e.message ??
                                          "Re-authentication failed.";
                                      isLoading = false;
                                    });
                                  }
                                } else {
                                  setState(() => isLoading = true);
                                  deleteAccount();
                                }
                              },
                              child:
                                  isLoading
                                      ? const SizedBox(
                                        width: 18,
                                        height: 18,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Color(0xFFF23943),
                                        ),
                                      )
                                      : const Text("Yes"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
      );
    },
  );
}
