import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:sports_app/Presentation/Pages/add_quote_screen.dart';
import 'package:sports_app/Presentation/Pages/explore_feed.dart';
import 'package:sports_app/Presentation/Pages/profile_screen.dart';
import 'package:sports_app/Presentation/Pages/quotes_screen.dart';
import 'package:sports_app/Presentation/Pages/quotes_screen2.dart';
import 'package:sports_app/Presentation/Pages/saved_quotes.dart';
import 'package:sports_app/Presentation/Pages/select_question_screen.dart';
import 'package:sports_app/Presentation/Views/sports_category_view.dart';
import 'package:sports_app/Presentation/Widgets/signin_page_buttons.dart';
import 'package:sports_app/Utils/Constants/images.dart';
import 'package:sports_app/Utils/Constants/text.dart';
import 'package:sports_app/Utils/Constants/ui.dart';
import 'package:sports_app/services/edit_profile_provider.dart';
import 'package:sports_app/services/image_picker_util.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    print('Bottom navigation item tapped: $index');
  }

  @override
  Widget build(BuildContext context) {
    final editProfileProvider = Provider.of<EditProfileProvider>(context);
    final userName = editProfileProvider.profileDetails?.firstName ?? "User";
    final userImage = editProfileProvider.profilePicture;
    return Scaffold(
      backgroundColor: Color(0xFF101922),
      body:
      //show quote or quiz
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ).copyWith(top: 65),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipOval(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileScreen(),
                          ),
                        );
                      },
                      child: SizedBox(
                        height: 59,
                        width: 59,
                        child:
                            userImage != null && userImage.isNotEmpty
                                ? CachedNetworkImage(
                                  imageUrl: ImagePickerUtil()
                                      .getUrlForUserUploadedImage(userImage),
                                  fit: BoxFit.cover,
                                  placeholder:
                                      (context, url) =>
                                          CircularProgressIndicator(),
                                  errorWidget:
                                      (context, url, error) => Image.asset(
                                        Images.img5,
                                        fit: BoxFit.cover,
                                      ),
                                )
                                : Image.asset(
                                  Images.img5,
                                  height: 59,
                                  width: 59,
                                ),
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Column(
                    children: [
                      Text(
                        "Welcome!",
                        style: TextStyle(
                          color: Color(0xFF7B8A99),
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        userName,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 100),

                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SavedQuotes()),
                      );
                    },
                    child: Icon(Icons.bookmark, color: Colors.white, size: 22),
                  ),
                ],
              ),
            ),

            SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 32,
                    color: Color(0xFFFFFFFF),
                    fontFamily: 'Montserrat',
                  ),
                  children: [
                    const TextSpan(text: "Quote of The Day\n"),
                    WidgetSpan(
                      child: ShaderMask(
                        blendMode: BlendMode.srcIn,
                        shaderCallback: (Rect bounds) {
                          return const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFF9F0FF7), Color(0xFFF03F3F)],
                          ).createShader(bounds);
                        },
                        child: const Text(
                          "For You!",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 40,
                            color:
                                Colors
                                    .white, // Apply white color, the shader will color it.
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 177,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFB33AFE).withAlpha(115),
                      blurRadius: 31,
                      offset: Offset(0, 5),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [Color(0xFF9F0FF7), Color(0xFF355EEF)],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                      ).copyWith(top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,

                        children: [
                          ClipOval(
                            child: Image.network(
                              Images.img6,
                              height: 49,
                              width: 49,
                            ),
                          ),
                          SizedBox(width: 11),
                          Text(
                            "Grane smith",
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                              fontSize: 21,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        LoremIpsum.p5,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Plus Jakarta sans",
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 38),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Explore More",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.network(
                          Images.img11,
                          height: 10,
                          width: 14,
                          color: Color(0xFF7B8A99),
                        ),
                        SizedBox(width: 2),

                        Text(
                          "Swipe left",
                          style: TextStyle(
                            fontFamily: "Plus Jakarta sans",
                            fontWeight: FontWeight.w300,
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            color: Color(0xFF7B8A99),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 13),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  SizedBox(
                    height: 238,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          left: 45,
                          right: 45,
                          child: ClipRRect(
                            borderRadius: UI.borderRadius36,

                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: UI.borderRadius36,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 6,
                                    color: Colors.black.withAlpha(77),
                                    offset: Offset(0, -3),
                                  ),
                                ],
                              ),
                              child: Image.network(
                                Images.img9,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 12,
                          left: 35,
                          right: 35,
                          child: ClipRRect(
                            borderRadius: UI.borderRadius36,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: UI.borderRadius36,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 6,
                                    color: Colors.black.withAlpha(77),
                                    offset: Offset(0, -3),
                                  ),
                                ],
                              ),
                              child: Image.network(
                                Images.img10,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 24,
                          left: 20,
                          right: 20,
                          child: ClipRRect(
                            borderRadius: UI.borderRadius36,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: UI.borderRadius36,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 6,
                                    color: Colors.black.withAlpha(77),
                                    offset: Offset(0, -3),
                                  ),
                                ],
                              ),
                              child: Image.network(
                                Images.img8,
                                fit: BoxFit.fitWidth,
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
            SizedBox(height: 28),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 23),
              child: SigninPageButtons(
                buttonText: "Explore Feed",
                onpressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ExploreFeed()),
                  );
                },
              ),
            ),
            SizedBox(height: 35),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Text(
                "Sports Categories",
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),

            SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SportsCategoryView(
                onCategorySelected: (category) {
                  // You can set a variable or call setState here
                },
                selectedCategory: null,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF1E2730),

        shape: CircleBorder(),
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddQuoteScreen()),
          );
        },
        child: Icon(Icons.add, color: Colors.red),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: PhysicalModel(
        elevation: 5,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),

        color: Color(0xFF101922),
        shadowColor: Color(0xFF000000).withAlpha(120),
        clipBehavior: Clip.antiAlias,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),

          child: BottomAppBar(
            color: Color(0xFF101822),
            shape: CircularNotchedRectangle(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                GestureDetector(
                  // Wrap with a GestureDetector
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuotesScreen(category: ''),
                      ), // Added required category parameter
                    );
                  }, // Move onTap here
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0x99E9353F), Color(0x00EA3640)],
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          // Add Icon here
                          Icons.format_quote_sharp,
                          color:
                              _selectedIndex == 0
                                  ? Colors.redAccent
                                  : Colors.grey,
                        ),
                        Text("Quotes", style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),
                ),

                SizedBox(width: 48.0),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QuotesScreen2()),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.network(Images.img12, height: 28, width: 28),
                      SizedBox(height: 3),

                      Text(
                        "Quiz",
                        style: TextStyle(
                          color:
                              _selectedIndex == 1
                                  ? Colors.redAccent
                                  : Colors.grey,
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
}
