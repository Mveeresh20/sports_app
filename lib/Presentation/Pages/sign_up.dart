import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sports_app/Presentation/Pages/sign_in.dart';
import 'package:sports_app/Presentation/Widgets/or_divider.dart';
import 'package:sports_app/Presentation/Widgets/signin_page_buttons.dart';
import 'package:sports_app/Utils/Constants/images.dart';
import 'package:sports_app/Utils/Constants/text.dart';
import 'package:sports_app/Utils/Constants/ui.dart';
import 'package:sports_app/services/auth_service.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final AuthService _authService = AuthService();

  void _handleSignUp() async {
    final user = await _authService.signUp(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );
    if (user != null) {
      print("User signed up: ${user.email}");
      // Navigate to HomePage
    } else {
      // Show error Snackbar/Dialog
    }
  }

  final _formKey = GlobalKey<FormState>();
  bool _isChecked = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String? _validateEmail(String? value) {
    const pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    final regex = RegExp(pattern);
    if (value == null || value.isEmpty) {
      return "Email is required";
    } else if (!regex.hasMatch(value)) {
      return "Enter a valid Email";
    }
    return null;
  }

  String? _validatePassword(String? value) {
    const pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    final regex2 = RegExp(pattern);
    if (value == null || value.isEmpty) {
      return "Password is required";
    } else if (!regex2.hasMatch(value)) {
      return "Password must be atleast 8 characters,\ninclude upper and lowe characters";
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value != _passwordController.text) {
      return "Password do not Match";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF101922),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 21,
              ).copyWith(top: 72),
              child: Container(
                child: RichText(
                  text: TextSpan(
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 32,
                      color: Color(0xFFFFFFFF),
                      height: 1.2,
                    ),
                    children: [
                      TextSpan(text: "Create an "),
                      TextSpan(
                        text: "Account",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700,
                          fontSize: 32,
                          color: Color(0xFFC1232C),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 4),
            Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 21),
                child: Text(
                  LoremIpsum.p3,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    color: Color(0xFF7B8A99),
                  ),
                ),
              ),
            ),
            SizedBox(height: 41),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Form(
                key: _formKey,
                child: Column(
                  spacing: 11,

                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 54,

                      child: TextFormField(
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: UI.borderRadius36,
                            borderSide: BorderSide(
                              width: 1,
                              color: Color(0xFF7B8A99),
                            ),
                          ),

                          labelText: "You Name",
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Color(0xFF7B8A99),
                          ),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Color(0xFF7B8A99),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: UI.borderRadius36,
                            borderSide: BorderSide(
                              width: 1,
                              color: Color(0xFF7B8A99),
                            ),
                          ),
                        ),
                        controller: _nameController,
                      ),
                    ),
                    Container(
                      height: 54,
                      decoration: BoxDecoration(
                        borderRadius: UI.borderRadius50,
                        border: Border.all(width: 1, color: Color(0xFF7B8A99)),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.text,

                        validator: _validateEmail,
                        decoration: InputDecoration(
                          border:
                              InputBorder
                                  .none, // Disables TextFormField's border
                          errorBorder:
                              InputBorder.none, // Disables error border
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,

                          labelText: "Enter address",
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Color(0xFF7B8A99),
                          ),
                          prefixIcon: Icon(
                            Icons.email,
                            color: Color(0xFF7B8A99),
                          ),
                        ),
                        controller: _emailController,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: UI.borderRadius50,
                        border: Border.all(width: 1, color: Color(0xFF7B8A99)),
                      ),
                      height: 54,
                      child: TextFormField(
                        validator: _validatePassword,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          errorBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          labelText: "Password",
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Color(0xFF7B8A99),
                          ),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Color(0xFF7B8A99),
                          ),
                        ),
                        controller: _passwordController,
                      ),
                    ),
                    SizedBox(
                      height: 54,
                      child: TextFormField(
                        validator: _validateConfirmPassword,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: UI.borderRadius50,
                            borderSide: BorderSide(
                              width: 1,
                              color: Color(0xFF7B8A99),
                            ),
                          ),

                          labelText: "Confirm Password",
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Color(0xFF7B8A99),
                          ),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Color(0xFF7B8A99),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: UI.borderRadius50,
                            borderSide: BorderSide(
                              width: 1,
                              color: Color(0xFF7B8A99),
                            ),
                          ),
                        ),
                        controller: _confirmPasswordController,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Container(
                child: Row(
                  children: [
                    Checkbox(
                      activeColor: Colors.red,
                      checkColor: Colors.white,
                      value: _isChecked,
                      onChanged: (bool? newValue) {
                        setState(() {
                          _isChecked = newValue!;
                        });
                      },
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {},
                        child: Text.rich(
                          TextSpan(
                            text: 'By Coninuing you accept the ',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 11,
                              color: Colors.white,
                            ),
                            children: [
                              TextSpan(
                                text: 'Terms & Conditions',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ).copyWith(top: 24),

              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SigninPageButtons(
                    buttonText: "Sign up",
                    onpressed: _handleSignUp,
                  ),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: UI.borderRadius36,
                      border: Border.all(width: 1, color: Color(0xFF7B8A99)),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.person, color: Colors.white),
                          SizedBox(width: 16),
                          Text(
                            "Continue as guest",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  OrDivider(
                    color: Color(0xFFE8E8E8),
                    thickness: 1,
                    indent: 0,
                    endIndent: 0,
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Color(0xFF949494),
                    ),
                  ),
                  SizedBox(height: 15),

                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(Images.img4, height: 21, width: 21),
                          SizedBox(width: 10),
                          Text(
                            "Sign in with apple",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Color(0xFF7B8A99),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignIn()),
                          );
                        },
                        child: Text(
                          "Sign in",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
