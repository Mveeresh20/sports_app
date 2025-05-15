import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sports_app/models/quote.dart';

import 'package:sports_app/services/profile_details.dart';
// Assuming you have this

class QuoteService {
  final DatabaseReference _quotesRef = FirebaseDatabase.instance.ref().child(
    'w02_users',
  );
  final UserService _userService = UserService();

  // Create a new quote
  Future<void> createQuote(Quote quote) async {
    final userId = _userService.getCurrentUserId();
    if (userId == null) {
      throw 'User not logged in';
    }
    final newQuote = Quote(
      quoteText: quote.quoteText,
      sportsCategory: quote.sportsCategory,
      backgroundImage: quote.backgroundImage,
      coverTheme: quote.coverTheme,
      userId: userId,
      createdAt: DateTime.now(),
    );
    await _quotesRef
        .child(userId)
        .child('quotes')
        .push()
        .set(newQuote.toJson());
  }

  // Read all quotes for the current user
  Stream<List<Quote>> getUserQuotes() {
    final userId = _userService.getCurrentUserId();
    if (userId == null) {
      return Stream.value([]);
    }
    return _quotesRef.child(userId).child('quotes').onValue.map((event) {
      final Map<dynamic, dynamic>? quotesMap =
          event.snapshot.value as Map<dynamic, dynamic>?;
      if (quotesMap == null) {
        return [];
      }
      return quotesMap.values.map((quoteData) {
        final key = quotesMap.keys.firstWhere((k) => quotesMap[k] == quoteData);
        final snapshot = event.snapshot.child(key);
        return Quote.fromSnapshot(snapshot);
      }).toList();
    });
  }

  // Update an existing quote
  Future<void> updateQuote(Quote quote) async {
    final userId = _userService.getCurrentUserId();
    if (userId == null) {
      throw 'User not logged in';
    }
    if (quote.id == null) {
      throw 'Quote ID cannot be null for update';
    }
    await _quotesRef
        .child(userId)
        .child('quotes')
        .child(quote.id!)
        .update(quote.toJson());
  }

  // Delete a quote
  Future<void> deleteQuote(String quoteId) async {
    final userId = _userService.getCurrentUserId();
    if (userId == null) {
      throw 'User not logged in';
    }
    await _quotesRef.child(userId).child('quotes').child(quoteId).remove();
  }

  // Function to like a quote
  Future<void> likeQuote(String quoteId) async {
    final userId = _userService.getCurrentUserId();
    if (userId == null) {
      throw 'User not logged in';
    }
    final quoteRef = _quotesRef.child(userId).child('quotes').child(quoteId);
    await quoteRef.update({'likes': ServerValue.increment(1)});
  }

  // Function to bookmark a quote
  Future<void> bookmarkQuote(String quoteId) async {
    final userId = _userService.getCurrentUserId();
    if (userId == null) {
      throw 'User not logged in';
    }
    final quoteRef = _quotesRef.child(userId).child('quotes').child(quoteId);
    await quoteRef.update({'bookmarkCount': ServerValue.increment(1)});
  }

  /// Fetches the saved quotes for the current user as a stream.
  Stream<List<Quote>> getSavedQuotes() {
    final userId = _userService.getCurrentUserId();
    if (userId == null) {
      // User not logged in, return empty stream
      return Stream.value([]);
    }
    return _quotesRef.child(userId).child('savedQuotes').onValue.asyncMap((
      event,
    ) async {
      final data = event.snapshot.value as Map<dynamic, dynamic>? ?? {};
      List<Quote> saved = [];
      for (var quoteId in data.keys) {
        final quoteSnap =
            await _quotesRef.child(userId).child('quotes').child(quoteId).get();
        if (quoteSnap.exists) {
          saved.add(Quote.fromSnapshot(quoteSnap));
        }
      }
      return saved;
    });
  }

  // Fetch all quotes for a category (across all users)
  Stream<List<Quote>> getQuotesForCategory(String category) {
    // This assumes your structure is w02_users/{userId}/quotes/{quoteId}
    return FirebaseDatabase.instance.ref().child('w02_users').onValue.map((
      event,
    ) {
      final usersMap = event.snapshot.value as Map<dynamic, dynamic>? ?? {};
      List<Quote> allQuotes = [];
      usersMap.forEach((userId, userData) {
        if (userData is Map && userData['quotes'] is Map) {
          (userData['quotes'] as Map).forEach((quoteId, quoteData) {
            if (quoteData['sportsCategory'] == category) {
              final snapshot = event.snapshot.child('$userId/quotes/$quoteId');
              allQuotes.add(Quote.fromSnapshot(snapshot));
            }
          });
        }
      });
      return allQuotes;
    });
  }

  // Save (bookmark) a quote for the current user
  Future<void> saveQuote(String quoteId) async {
    final userId = _userService.getCurrentUserId();
    if (userId == null) throw 'User not logged in';
    await FirebaseDatabase.instance
        .ref()
        .child('w02_users')
        .child(userId)
        .child('savedQuotes')
        .child(quoteId)
        .set(true);
  }
}


// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:sports_app/models/quote.dart';

// import 'package:sports_app/services/profile_details.dart';
// // Assuming you have this

// class QuoteService {
//   final DatabaseReference _quotesRef = FirebaseDatabase.instance.ref().child('w02_users');
//   final UserService _userService = UserService();

//   // Create a new quote
//   Future<void> createQuote(Quote quote) async {
//     final userId = _userService.getCurrentUserId();
//     if (userId == null) {
//       throw 'User not logged in';
//     }
//     final newQuote = Quote(
//       quoteText: quote.quoteText,
//       sportsCategory: quote.sportsCategory,
//       backgroundImage: quote.backgroundImage,
//       coverTheme: quote.coverTheme,
//       userId: userId,
//       createdAt: DateTime.now(),
//     );
//     await _quotesRef.child(userId).child('quotes').push().set(newQuote.toJson());
//   }

//   // Read all quotes for the current user
//   Stream<List<Quote>> getUserQuotes() {
//     final userId = _userService.getCurrentUserId();
//     if (userId == null) {
//       return Stream.value([]);
//     }
//     return _quotesRef.child(userId).child('quotes').onValue.map((event) {
//       final Map<dynamic, dynamic>? quotesMap = event.snapshot.value as Map<dynamic, dynamic>?;
//       if (quotesMap == null) {
//         return [];
//       }
//       return quotesMap.values.map((quoteData) {
//         final key = quotesMap.keys.firstWhere((k) => quotesMap[k] == quoteData);
//         final snapshot = event.snapshot.child(key);
//         return Quote.fromSnapshot(snapshot);
//       }).toList();
//     });
//   }

//   // Update an existing quote
//   Future<void> updateQuote(Quote quote) async {
//     final userId = _userService.getCurrentUserId();
//     if (userId == null) {
//       throw 'User not logged in';
//     }
//     if (quote.id == null) {
//       throw 'Quote ID cannot be null for update';
//     }
//     await _quotesRef.child(userId).child('quotes').child(quote.id!).update(quote.toJson());
//   }

//   // Delete a quote
//   Future<void> deleteQuote(String quoteId) async {
//     final userId = _userService.getCurrentUserId();
//     if (userId == null) {
//       throw 'User not logged in';
//     }
//     await _quotesRef.child(userId).child('quotes').child(quoteId).remove();
//   }

//   // Optional: Function to like a quote
//   Future<void> likeQuote(String quoteId) async {
//     final userId = _userService.getCurrentUserId();
//     if (userId == null) {
//       throw 'User not logged in';
//     }
//     final quoteRef = _quotesRef.child(userId).child('quotes').child(quoteId).child('likes');
//     await quoteRef.transaction((currentLikes) {
//       return (currentLikes ?? 0) + 1;
//     });
//   }

//   // Optional: Function to bookmark a quote
//   Future<void> bookmarkQuote(String quoteId) async {
//     final userId = _userService.getCurrentUserId();
//     if (userId == null) {
//       throw 'User not logged in';
//     }
//     final quoteRef = _quotesRef.child(userId).child('quotes').child(quoteId).child('bookmarkCount');
//     await quoteRef.transaction((currentBookmarks) {
//       return (currentBookmarks ?? 0) + 1;
//     });
//   }
// }