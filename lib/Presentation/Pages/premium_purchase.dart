import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sports_app/Presentation/Widgets/signin_page_buttons.dart';
import 'package:sports_app/Utils/Constants/images.dart';
import 'package:sports_app/Utils/Constants/text.dart';

class PremiumPurchase extends StatefulWidget {
  const PremiumPurchase({super.key});

  @override
  State<PremiumPurchase> createState() => _PremiumPurchaseState();
}

class _PremiumPurchaseState extends State<PremiumPurchase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.network(
              Images.img14,
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(65),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF000000), Color(0xFF101922)],
                ),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 21,
                    ).copyWith(top: 64),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.arrow_back_ios_new_outlined,
                          color: Colors.white,
                          size: 16,
                        ),
                        const SizedBox(width: 76),
                        Center(
                          child: const Text(
                            "Premium Purchase",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
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
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            width: 1,
                            color: Color(0xFF7B8A99),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 9,
                          ),
                          child: Text(
                            "Restore Plan",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFF23943),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 90),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 31),
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontFamily: "Open Sans",
                          fontWeight: FontWeight.w700,
                          fontSize: 35,
                          color: Color(0xFFFFFFFF),
                          height: 1.2,
                        ),
                        children: [
                          TextSpan(text: "Unlock\n"),
                          TextSpan(
                            text: "All the Features\n",
                            style: TextStyle(
                              fontFamily: "Open Sans",
                              fontWeight: FontWeight.w700,
                              fontSize: 35,
                              color: Color(0xFFC1232C),
                            ),
                          ),
                          TextSpan(text: "Now"),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 45),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 31),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Key Features",
                          style: TextStyle(
                            fontFamily: "Open Sans",
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.network(Images.img15, width: 15, height: 15),
                            SizedBox(width: 6),
                            Text(
                              "Add more quotes",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 14),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.network(Images.img16, width: 15, height: 15),
                            SizedBox(width: 6),
                            Text(
                              LoremIpsum.p15,
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1, color: Color(0xFF7B8A99)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 19,
                          vertical: 19,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "One Time Purchase",
                              style: TextStyle(
                                fontFamily: "Inter",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFFF4F4F4),
                              ),
                            ),
                            Text(
                              "0.99\$",
                              style: TextStyle(
                                fontFamily: "Inter",
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFFF4F4F4),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 35),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ).copyWith(bottom: 20),
                    child: SigninPageButtons(
                      buttonText: "Purchase",
                      onpressed: () {
                        showPremiumLimitDialog(context);
                      },
                    ),
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

void showPremiumLimitDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder:
        (context) => Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: 289,
              height: 375,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.3),
                image: DecorationImage(
                  image: NetworkImage(Images.img1),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  // Overlay for dark effect
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.3),
                      color: Colors.black.withOpacity(0.55),
                    ),
                  ),
                  // Content
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 18,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Close button
                        Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.18),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 22,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Main message
                        RichText(
                          text: TextSpan(
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                            children: [
                              const TextSpan(
                                text: "You Already have added\n5 quotes. ",
                              ),
                              TextSpan(
                                text: "Upgrade to premium to",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color: Color(0xFFF23943),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Features
                        featureRow("Unlimited Listening to Quotes Aloud"),
                        const SizedBox(height: 6),
                        featureRow("Add More Quotes."),
                        const SizedBox(height: 6),
                        featureRow("Explore all Quotes of each Catogaries."),
                        const Spacer(),
                        // Get premium button
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32),
                              ),
                              elevation: 0,
                              backgroundColor: Colors.transparent,
                            ),
                            onPressed: () {
                              // TODO: Add your premium purchase logic here
                              Navigator.of(context).pop();
                            },
                            child: Ink(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFFF23943),
                                    Color(0xFFC1232C),
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(32),
                                ),
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "Get premium",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
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
          ),
        ),
  );
}

// Helper for feature row
Widget featureRow(String text) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Icon(Icons.check_circle, color: Color(0xFFF23943), size: 18),
      const SizedBox(width: 8),
      Expanded(
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            fontSize: 13,
            color: Colors.white,
          ),
        ),
      ),
    ],
  );
}
