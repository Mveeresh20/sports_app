import 'dart:developer';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sports_app/services/background_image.dart';
import 'package:sports_app/services/profile_details.dart';
 // Make sure this is correctly imported

class AddQuoteProvider extends ChangeNotifier {
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

  String? _backgroundImage;

  String? get backgroundImage => _backgroundImage;

  set backgroundImage(String? value) {
    _backgroundImage = value;
    notifyListeners();
  }

  Future<void> updateBackgroundImage(String imageUrl, BuildContext context) async {
    String? userId = UserService().getCurrentUserId();
    if (userId != null) {
      DatabaseReference ref =
          FirebaseDatabase.instance.ref('w02_users/$userId/quoteBackground');

      await ref.update({
        'imageBackground': imageUrl,
      });

      backgroundImage = await fetchBackgroundImage();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Background image uploaded successfully"),
          backgroundColor: Colors.grey,
        ),
      );
    } else {
      print('User is not authenticated');
    }
  }

  Future<String?> fetchBackgroundImage() async {
    String? userId = UserService().getCurrentUserId();
    if (userId != null) {
      DatabaseReference ref =
          FirebaseDatabase.instance.ref('w02_users/$userId/quoteBackground');

      DatabaseEvent event = await ref.once();
      DataSnapshot snapshot = event.snapshot;

      if (snapshot.exists) {
        final data = snapshot.value;
        if (data is Map) {
          Map<String, dynamic> imageData = Map<String, dynamic>.from(data);
          BackgroundImage backgroundModel = BackgroundImage.fromMap(imageData);
          backgroundImage = backgroundModel.imageBackground ?? '';
          notifyListeners();
          return backgroundImage;
        }
      } else {
        print('Background image not found');
        return null;
      }
    } else {
      print('User is not authenticated');
      return null;
    }
  }

  Future<void> loadInitialData() async {
    setLoading(true);
    try {
      await fetchBackgroundImage();
      setLoading(false);
    } catch (e) {
      log('Error loading background image: $e');
      setLoading(false);
      setError(true);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
