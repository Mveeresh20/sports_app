import 'package:firebase_database/firebase_database.dart';

class Quote {
  String? id; 
  String quoteText;
  String? sportsCategory;
  String? backgroundImage;
  String? coverTheme; 
  String userId;
  int likes;
  int bookmarkCount;
  DateTime createdAt;

  Quote({
    this.id,
    required this.quoteText,
    this.sportsCategory,
    this.backgroundImage,
    this.coverTheme,
    required this.userId,
    this.likes = 0,
    this.bookmarkCount = 0,
    required this.createdAt,
  });

  
  factory Quote.fromSnapshot(DataSnapshot snapshot) {
    final data = snapshot.value as Map<dynamic, dynamic>?;
    if (data == null) {
      throw 'Invalid quote data: null snapshot value';
    }
    return Quote(
      id: snapshot.key,
      quoteText: data['quoteText'] ?? '',
      sportsCategory: data['sportsCategory'],
      backgroundImage: data['backgroundImage'],
      coverTheme: data['coverTheme'],
      userId: data['userId'] ?? '',
      likes: data['likes'] ?? 0,
      bookmarkCount: data['bookmarkCount'] ?? 0,
      createdAt: DateTime.tryParse(data['createdAt'] ?? '') ?? DateTime.now(),
    );
  }

 
  Map<String, dynamic> toJson() {
    return {
      'quoteText': quoteText,
      'sportsCategory': sportsCategory,
      'backgroundImage': backgroundImage,
      'coverTheme': coverTheme,
      'userId': userId,
      'likes': likes,
      'bookmarkCount': bookmarkCount,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
