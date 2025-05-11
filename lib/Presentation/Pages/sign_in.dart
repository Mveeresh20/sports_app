import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sports_app/Presentation/Pages/sign_up.dart';
import 'package:sports_app/Presentation/Widgets/or_divider.dart';
import 'package:sports_app/Presentation/Widgets/signin_page_buttons.dart';
import 'package:sports_app/Utils/Constants/images.dart';
import 'package:sports_app/Utils/Constants/ui.dart';
import 'package:flutter/services.dart';
import 'package:sports_app/services/auth_service.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();

  void _handleSignIn() async {
    final user = await _authService.signIn(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    if (user != null) {
      print("User signed in : ${user.email}");
    } else {
      print("error");
    }
  }

  bool _isChecked = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  void showSystemUI() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  @override
  void initState() {
    super.initState();
    showSystemUI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF101922),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,

            children: [
              Stack(
                children: [
               Image.network(Images.img1, fit: BoxFit.cover),
                  Positioned(
                    top: 111,
                    left: 28,
                    child: RichText(
                      text: TextSpan(
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 48,
                          color: Colors.white,
                          height: 1.22,
                        ),
                        children: [
                          TextSpan(text: "Hello,\n"),
                          TextSpan(
                            text: "Welcome",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 48,
                              color: Color(0xFFC1232C),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 292,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF000000).withAlpha(10),
                            offset: Offset(0, 6),
                            blurRadius: 2,
                            spreadRadius: 0,
                          ),
                          BoxShadow(
                            color: Color(0xFF000000).withAlpha(31),
                            blurRadius: 16,
                            spreadRadius: 0,
                          ),
                        ],

                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                        color: Color(0xFF1E2730),
                      ),
                      height: 560,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                            ).copyWith(top: 39),
                            child: Container(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 50,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: UI.borderRadius36,
                                          borderSide: BorderSide(
                                            width: 1,
                                            color: Color(0xFF7B8A99),
                                          ),
                                        ),

                                        labelText: "Enter Your Email",
                                        labelStyle: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: Color(0xFF7B8A99),
                                        ),
                                        prefixIcon: Icon(
                                          Icons.email_outlined,
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
                                      controller: _emailController,
                                    ),
                                  ),
                                  SizedBox(height: 22),
                                  SizedBox(
                                    height: 50,
                                    child: TextFormField(
                                      obscureText: true,

                                      controller: _passwordController,
                                      decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: UI.borderRadius36,
                                          borderSide: BorderSide(
                                            width: 1,
                                            color: Color(0xFF7B8A99),
                                          ),
                                        ),
                                        labelText: "Password",
                                        labelStyle: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: Color(0xFF7B8A99),
                                        ),
                                        prefixIcon: Icon(
                                          Icons.lock,
                                          color: Color(0xFF7B8A99),
                                        ),
                                        suffixIcon: Icon(
                                          Icons.visibility_rounded,
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
                                    ),
                                  ),
                                  SizedBox(height: 9),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      "Forgot Password?",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: Color(0xFFFFFFFF),
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
                                  buttonText: "Sign In",
                                  onpressed: _handleSignIn,
                                ),
                                SizedBox(height: 20),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: UI.borderRadius36,
                                    border: Border.all(
                                      width: 1,
                                      color: Color(0xFF7B8A99),
                                    ),
                                  ),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                    ),
                                    onPressed: () {},
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.network(
                                          Images.img4,
                                          height: 21,
                                          width: 21,
                                        ),
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
                                      "Don't have an account?",
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
                                          MaterialPageRoute(
                                            builder: (context) => SignUp(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        "Sign up",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15),

                                Container(
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
                                              text:
                                                  'By Coninuing you accept the ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 11,
                                                color: Colors.white,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: 'Terms and Conditions',
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
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
