import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sports_app/Utils/Constants/images.dart';
import 'package:sports_app/models/quote.dart';
import 'package:sports_app/services/quotes_provider.dart';
import 'package:sports_app/services/profile_details.dart';
import 'package:sports_app/services/image_picker_util.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:io';
import 'package:sports_app/services/edit_profile_provider.dart';

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

class MyQuotes extends StatefulWidget {
  const MyQuotes({super.key});

  @override
  State<MyQuotes> createState() => _MyQuotesState();
}

class _MyQuotesState extends State<MyQuotes> {
  String? userProfileImage;
  String? userName;

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () =>
          Provider.of<QuotesProvider>(context, listen: false).fetchUserQuotes(),
    );
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    String? userId = UserService().getCurrentUserId();
    if (userId != null) {
      final ref = FirebaseDatabase.instance.ref(
        'w02_users/$userId/profileDetails',
      );
      final snapshot = await ref.get();
      if (snapshot.exists) {
        final data = snapshot.value as Map?;
        setState(() {
          userProfileImage = data?['imageProfile'] as String?;
          userName = data?['firstName'] as String? ?? "User";
        });
      }
    }
  }

  Future<void> _handleDeleteQuote(String quoteId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Delete Quote'),
            content: const Text('Are you sure you want to delete this quote?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Delete'),
              ),
            ],
          ),
    );

    if (confirmed == true) {
      try {
        await Provider.of<QuotesProvider>(
          context,
          listen: false,
        ).deleteQuote(quoteId);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Quote deleted successfully')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error deleting quote: $e')));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final editProfileProvider = Provider.of<EditProfileProvider>(context);
    final userImage = editProfileProvider.profilePicture;
    final userName = editProfileProvider.profileDetails?.firstName ?? "User";

    return Consumer<QuotesProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Scaffold(
            backgroundColor: Color(0xFF101922),
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (provider.error != null) {
          return Scaffold(
            backgroundColor: const Color(0xFF101922),
            body: Center(
              child: Text(
                'Error: ${provider.error}',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        }

        final quotes = provider.quotes;

        return Scaffold(
          backgroundColor: const Color(0xFF101922),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Color(0xFF27313B), width: 1),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 21,
                    ).copyWith(top: 64, bottom: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.arrow_back_ios_new_outlined,
                          color: Colors.white,
                          size: 16,
                        ),
                        const SizedBox(width: 89),
                        const Text(
                          "My Quotes",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (quotes.isEmpty)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        'No quotes yet. Add your first quote!',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  )
                else
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: quotes.length,
                    separatorBuilder:
                        (context, index) => const SizedBox(height: 19),
                    itemBuilder: (context, index) {
                      final quote = quotes[index];

                      // QUOTE BACKGROUND
                      Widget quoteBackground;
                      if (quote.backgroundImage != null &&
                          quote.backgroundImage!.isNotEmpty) {
                        quoteBackground = ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            File(quote.backgroundImage!),
                            width: double.infinity,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        );
                      } else if (quote.coverTheme != null &&
                          quote.coverTheme!.isNotEmpty) {
                        final theme = coverThemes.firstWhere(
                          (t) => t.id == quote.coverTheme,
                          orElse: () => coverThemes.first,
                        );
                        quoteBackground = Container(
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: theme.gradient,
                          ),
                        );
                      } else {
                        quoteBackground = Container(
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xFF1E2730),
                          ),
                        );
                      }

                      // USER IMAGE
                      Widget userImageWidget;
                      if (userImage != null && userImage.isNotEmpty) {
                        userImageWidget = ClipOval(
                          child: Image.network(
                            ImagePickerUtil().getUrlForUserUploadedImage(
                              userImage,
                            ),
                            height: 49,
                            width: 49,
                            fit: BoxFit.cover,
                          ),
                        );
                      } else {
                        userImageWidget = ClipOval(
                          child: Icon(Icons.person, size: 49),
                        );
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 13),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: const Color(0xFF27313B),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ).copyWith(top: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          2640,
                                        ),
                                        color: const Color(0xFF273130),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 7,
                                          vertical: 5,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            userImageWidget,
                                            const SizedBox(width: 8),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  userName,
                                                  style: const TextStyle(
                                                    fontFamily: "Montserrat",
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  "Category: ${quote.sportsCategory ?? ''}",
                                                  style: const TextStyle(
                                                    fontFamily: "Montserrat",
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap:
                                          () => _handleDeleteQuote(quote.id!),
                                      child: Container(
                                        height: 45,
                                        width: 45,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            3300,
                                          ),
                                          color: const Color(0xFF273130),
                                        ),
                                        child: const Center(
                                          child: Icon(
                                            Icons.delete_outline,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              // QUOTE BACKGROUND
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Stack(
                                  children: [
                                    quoteBackground,
                                    Container(
                                      height: 120,
                                      width: double.infinity,
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 10,
                                        ),
                                        child: Text(
                                          quote.quoteText,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            fontStyle: FontStyle.italic,
                                            color: Colors.white,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 8,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap:
                                          () => Provider.of<QuotesProvider>(
                                            context,
                                            listen: false,
                                          ).likeQuote(quote.id!),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            2420,
                                          ),
                                          color: const Color(0xFF273130),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 18,
                                            vertical: 7,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.favorite,
                                                color: Color(0xFFF24E1E),
                                              ),
                                              const SizedBox(width: 11),
                                              Text(
                                                "${quote.likes}",
                                                style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white.withAlpha(
                                                    128,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap:
                                          () => Provider.of<QuotesProvider>(
                                            context,
                                            listen: false,
                                          ).bookmarkQuote(quote.id!),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            2420,
                                          ),
                                          color: const Color(0xFF273130),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 18,
                                            vertical: 7,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.bookmark,
                                                color: Color(0xFFFFCD1B),
                                              ),
                                              const SizedBox(width: 11),
                                              Text(
                                                "${quote.bookmarkCount}",
                                                style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white.withAlpha(
                                                    128,
                                                  ),
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
                      );
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
