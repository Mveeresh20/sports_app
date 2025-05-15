import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sports_app/Presentation/Pages/my_quotes.dart';
import 'package:sports_app/Presentation/Pages/profile_screen.dart';
import 'package:sports_app/Presentation/Views/sports_category_view.dart';
import 'package:sports_app/Presentation/Widgets/signin_page_buttons.dart';
import 'package:sports_app/Presentation/Widgets/skip_butoon.dart';
import 'package:sports_app/services/add_quote_provider.dart';
import 'package:sports_app/services/image_picker_util.dart';
import 'package:sports_app/services/quotes_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sports_app/Presentation/Pages/home_screen.dart';

final List<CoverTheme> coverThemes = [
  CoverTheme(
    id: 'theme1',
    gradient: LinearGradient(colors: [Color(0xFF9F0FF7), Color(0xFF355EEF)]),
  ),
  CoverTheme(
    id: 'theme2',
    gradient: LinearGradient(colors: [Color(0xFFFC5000), Color(0xFF9F0FF7)]),
  ),
  CoverTheme(
    id: 'theme3',
    gradient: LinearGradient(colors: [Color(0xFFFC5000), Color(0xFF160FF7)]),
  ),
  CoverTheme(
    id: 'theme4',
    gradient: LinearGradient(colors: [Color(0xFFFCBD00), Color(0xFF9F0FF7)]),
  ),
  CoverTheme(
    id: 'theme5',
    gradient: LinearGradient(colors: [Color(0xFF1E2730), Color(0xFF31404F)]),
  ),
];

class CoverTheme {
  final String id;
  final LinearGradient gradient;
  CoverTheme({required this.id, required this.gradient});
}

class AddQuoteScreen extends StatefulWidget {
  const AddQuoteScreen({super.key});

  @override
  State<AddQuoteScreen> createState() => _AddQuoteScreenState();
}

class _AddQuoteScreenState extends State<AddQuoteScreen> {
  late final AddQuoteProvider _provider;
  String? _selectedCategory;
  String? _selectedCoverTheme;
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    _provider = AddQuoteProvider();
  }

  final TextEditingController _quoteController = TextEditingController();

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        _selectedCoverTheme = null; 
      });
    }
  }

  void _selectCover(String id) {
    setState(() {
      _selectedCoverTheme = id;
      _imageFile = null; 
    });
  }

  Future<void> _handleAddQuote() async {
    if (_quoteController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter a quote')));
      return;
    }
    if (_selectedCategory == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select a category')));
      return;
    }

    String? imagePath;
    if (_imageFile != null) {
      imagePath = _imageFile!.path;
    }

    await Provider.of<QuotesProvider>(context, listen: false).createQuote(
      quoteText: _quoteController.text,
      sportsCategory: _selectedCategory!,
      backgroundImage: imagePath,
      coverTheme: _selectedCoverTheme,
    );

    
    setState(() {
      _imageFile = null;
      _selectedCoverTheme = null;
      _selectedCategory = null;
      _quoteController.clear();
    });

    
    showQuotePostedDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddQuoteProvider>.value(
      value: _provider,
      child: Consumer<AddQuoteProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            backgroundColor: const Color(0xFF101922),
            body: SafeArea(
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
                          ), 
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
                          ).withAlpha(128), 
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Color(0xFF1E2730), // Border color
                            width: 1, // Border width
                          ),
                        ),
                        child: TextField(
                          controller: _quoteController,
                          cursorColor: Colors.white, // Cursor color

                          maxLines:
                              null, 
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
                      child: SportsCategoryView(
                        onCategorySelected: (category) {
                          setState(() {
                            _selectedCategory = category;
                          });
                        },
                        selectedCategory: _selectedCategory,
                      ),
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
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          width: double.infinity,
                          height: 148,
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E2730),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.white24),
                          ),
                          child:
                              _imageFile != null
                                  ? ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(
                                      _imageFile!,
                                      width: double.infinity,
                                      height: 148,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                  : Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFAFBFC),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 11,
                                          vertical: 11,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            Icon(
                                              Icons.cloud_upload,
                                              color: Color(0xFF121212),
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              'Upload Image',
                                              style: TextStyle(
                                                color: Color(0xFF121212),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                        ),
                      ),
                    ),

                    SizedBox(height: 28),
                    Center(
                      child: Text(
                        "Or",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Color(0xFF7B8A99),
                        ),
                      ),
                    ),
                    SizedBox(height: 28),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "Select Cover Theme",
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
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children:
                              coverThemes.map((theme) {
                                final isSelected =
                                    _selectedCoverTheme == theme.id;
                                return GestureDetector(
                                  onTap: () => _selectCover(theme.id),
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 12),
                                    decoration: BoxDecoration(
                                      border:
                                          isSelected
                                              ? Border.all(
                                                color: Colors.red,
                                                width: 2,
                                              )
                                              : null,
                                      gradient: theme.gradient,
                                    ),
                                    height: 50,
                                    width: 50,
                                  ),
                                );
                              }).toList(),
                        ),
                      ),
                    ),
                    SizedBox(height: 167),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: Column(
                        children: [
                          addButton(onPressed: _handleAddQuote),
                          const SizedBox(height: 8),
                          skipButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

void showQuotePostedDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder:
        (context) => Center(
          child: Material(
            color: Colors.transparent, // Ensures no extra background
            child: Container(
              width: 289,
              height: 290,
              decoration: BoxDecoration(
                color: const Color(0xFF1E2730),
                borderRadius: BorderRadius.circular(18.3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 11.6,
                    offset: const Offset(0, 3.51),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Woo Hoo!",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w800,
                      fontSize: 36,
                      color: const Color(0xFFC1232C),
                      decoration: TextDecoration.none, // Remove underline
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Your Quote has been Posted",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      color: Colors.white.withOpacity(0.85),
                      decoration: TextDecoration.none, // Remove underline
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: 200,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFC1232C),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(); // Close dialog
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (_) => const HomeScreen()),
                          (route) => false,
                        );
                      },
                      child: Text(
                        "Back to Home",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.white,
                          decoration: TextDecoration.none, // Remove underline
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
  );
}

Widget addButton({required VoidCallback onPressed}) {
  return Container(
    width: double.infinity,
    height: 55,
    margin: const EdgeInsets.only(bottom: 8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(32),
      gradient: const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [Color(0xFFF23943), Color(0xFFC1232C)],
      ),
      boxShadow: [
        BoxShadow(
          color: Color(0xFFFC5000).withOpacity(0.24),
          blurRadius: 12,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(32),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Center(
            child: Text(
              "Add",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 18,
                fontFamily: "Poppins",
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

Widget skipButton({required VoidCallback onPressed}) {
  return Container(
    width: double.infinity,
    height: 55,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(32),
      border: Border.all(color: Color(0xFFD3D3D3), width: 1),
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(32),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Center(
            child: Text(
              "Cancel",
              style: TextStyle(
                color: Color(0xFFD3D3D3),
                fontWeight: FontWeight.w700,
                fontSize: 18,
                fontFamily: "Poppins",
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
