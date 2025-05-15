import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';
import 'package:sports_app/Utils/Constants/images.dart';
import 'package:sports_app/services/edit_profile_provider.dart';
import 'package:sports_app/services/image_picker_util.dart';

class SavedQuotes extends StatefulWidget {
  const SavedQuotes({super.key});

  @override
  State<SavedQuotes> createState() => _SavedQuotesState();
}

class _SavedQuotesState extends State<SavedQuotes> {
  List<Map<String, dynamic>> _savedQuotes = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchSavedQuotes();
  }

  Future<void> _fetchSavedQuotes() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        setState(() {
          _error = "User not authenticated";
          _isLoading = false;
        });
        return;
      }

      final ref = FirebaseDatabase.instance
          .ref()
          .child('w02_users')
          .child(user.uid)
          .child('savedQuotes');

      final snapshot = await ref.get();
      final data = snapshot.value as Map<dynamic, dynamic>? ?? {};

      setState(() {
        _savedQuotes =
            data.entries
                .map<Map<String, dynamic>>(
                  (e) => {
                    'id': e.key,
                    'text': e.value['text'] ?? '',
                    'imageUrl': e.value['imageUrl'] ?? '',
                    'category': e.value['category'] ?? '',
                    'savedAt':
                        e.value['savedAt'] ?? DateTime.now().toIso8601String(),
                    'likes': e.value['likes'] ?? 0,
                    'bookmarkCount': e.value['bookmarkCount'] ?? 0,
                  },
                )
                .toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _unsaveQuote(String quoteId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: const Color(0xFF1E2730),
            title: const Text(
              'Remove Quote',
              style: TextStyle(color: Colors.white),
            ),
            content: const Text(
              'Are you sure you want to remove this quote from saved quotes?',
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text(
                  'Remove',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
    );

    if (confirmed != true) return;

    setState(() => _isLoading = true);

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw "User not authenticated";

      await FirebaseDatabase.instance
          .ref()
          .child('w02_users')
          .child(user.uid)
          .child('savedQuotes')
          .child(quoteId)
          .remove();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Quote removed from saved quotes')),
      );

      _fetchSavedQuotes(); // Refresh the list
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error removing quote: $e')));
    }
  }

  Future<void> _likeQuote(String quoteId, int currentLikes) async {
    setState(() => _isLoading = true);

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw "User not authenticated";

      // Update like count in saved quotes reference
      await FirebaseDatabase.instance
          .ref()
          .child('w02_users')
          .child(user.uid)
          .child('savedQuotes')
          .child(quoteId)
          .update({'likes': currentLikes + 1});

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Quote liked!')));

      _fetchSavedQuotes(); // Refresh the list
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error liking quote: $e')));
    }
  }

  Future<void> _bookmarkQuote(String quoteId, int currentBookmarkCount) async {
    setState(() => _isLoading = true);

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw "User not authenticated";

      // Update bookmark count in saved quotes reference
      await FirebaseDatabase.instance
          .ref()
          .child('w02_users')
          .child(user.uid)
          .child('savedQuotes')
          .child(quoteId)
          .update({'bookmarkCount': currentBookmarkCount + 1});

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bookmark count increased!')),
      );

      _fetchSavedQuotes(); // Refresh the list
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating bookmark count: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<EditProfileProvider>(context);
    final userImage = profileProvider.profilePicture;
    final userName = profileProvider.profileDetails?.firstName ?? "User";

    return Scaffold(
      backgroundColor: const Color(0xFF101922),
      body: SafeArea(
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
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_back_ios_new_outlined,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                    const SizedBox(width: 89),
                    const Text(
                      "Saved Quotes",
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
            Padding(
              padding: const EdgeInsets.only(
                left: 21,
                top: 18,
                right: 21,
                bottom: 10,
              ),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                  children: [
                    const TextSpan(
                      text: 'Saved Quotes – ',
                      style: TextStyle(color: Colors.white),
                    ),
                    WidgetSpan(
                      child: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return const LinearGradient(
                            colors: [Color(0xFFF23943), Color(0xFFFF7A00)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds);
                        },
                        blendMode: BlendMode.srcIn,
                        child: const Text(
                          'Motivate ',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: 28,
                          ),
                        ),
                      ),
                    ),
                    WidgetSpan(
                      child: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return const LinearGradient(
                            colors: [Color(0xFFB16CEA), Color(0xFFFF5E69)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds);
                        },
                        blendMode: BlendMode.srcIn,
                        child: const Text(
                          'Yourself Anytime!',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: 28,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child:
                  _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : _error != null
                      ? Center(
                        child: Text(
                          'Error: $_error',
                          style: const TextStyle(color: Colors.white),
                        ),
                      )
                      : _savedQuotes.isEmpty
                      ? const Center(
                        child: Text(
                          "No saved quotes",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                      : ListView.separated(
                        padding: const EdgeInsets.all(13),
                        itemCount: _savedQuotes.length,
                        separatorBuilder:
                            (context, index) => const SizedBox(height: 19),
                        itemBuilder: (context, index) {
                          final quote = _savedQuotes[index];

                          // User image widget
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
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    height: 49,
                                    width: 49,
                                    color: Colors.grey[800],
                                    child: const Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    ),
                                  );
                                },
                              ),
                            );
                          } else {
                            userImageWidget = ClipOval(
                              child: Image.network(
                                Images.img5,
                                height: 49,
                                width: 49,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    height: 49,
                                    width: 49,
                                    color: Colors.grey[800],
                                    child: const Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    ),
                                  );
                                },
                              ),
                            );
                          }

                          // Quote background
                          Widget quoteBackground = ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              quote['imageUrl'],
                              width: double.infinity,
                              height: 120,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFF9F0FF7),
                                        Color(0xFF355EEF),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );

                          return Container(
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
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Category: ${quote['category'] ?? ''}",
                                                    style: const TextStyle(
                                                      fontFamily: "Montserrat",
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w400,
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
                                        onTap: () => _unsaveQuote(quote['id']),
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
                                              Icons.more_vert,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                // Quote background and text
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
                                            quote['text'],
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
                                // Actions row (like and bookmark)
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
                                            () => _likeQuote(
                                              quote['id'],
                                              quote['likes'] ?? 0,
                                            ),
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
                                                  "${quote['likes'] ?? 0}",
                                                  style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white
                                                        .withAlpha(128),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap:
                                            () => _bookmarkQuote(
                                              quote['id'],
                                              quote['bookmarkCount'] ?? 0,
                                            ),
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
                                                  "${quote['bookmarkCount'] ?? 0}",
                                                  style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white
                                                        .withAlpha(128),
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
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
