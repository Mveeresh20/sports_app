import 'package:flutter/foundation.dart';
import 'package:sports_app/models/quote.dart';
import 'package:sports_app/services/quote_service.dart';

class QuotesProvider with ChangeNotifier {
  final QuoteService _quoteService = QuoteService();
  List<Quote> _quotes = [];
  List<Quote> _savedQuotes = [];
  bool _isLoading = false;
  String? _error;

  List<Quote> get quotes => _quotes;
  List<Quote> get savedQuotes => _savedQuotes;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Fetch user's quotes
  Future<void> fetchUserQuotes() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _quoteService.getUserQuotes().listen(
        (quotes) {
          _quotes = quotes;
          _isLoading = false;
          notifyListeners();
        },
        onError: (error) {
          _error = error.toString();
          _isLoading = false;
          notifyListeners();
        },
      );
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // Create a new quote
  Future<void> createQuote({
    required String quoteText,
    required String sportsCategory,
    String? backgroundImage,
    String? coverTheme,
  }) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final quote = Quote(
        quoteText: quoteText,
        sportsCategory: sportsCategory,
        backgroundImage: backgroundImage,
        coverTheme: coverTheme,
        userId: '', // Will be set by QuoteService
        createdAt: DateTime.now(),
      );

      await _quoteService.createQuote(quote);
      await fetchUserQuotes(); // Refresh the quotes list
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // Update a quote
  Future<void> updateQuote(Quote quote) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _quoteService.updateQuote(quote);
      await fetchUserQuotes(); // Refresh the quotes list
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // Delete a quote
  Future<void> deleteQuote(String quoteId) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _quoteService.deleteQuote(quoteId);
      await fetchUserQuotes(); // Refresh the quotes list
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // Like a quote
  Future<void> likeQuote(String quoteId) async {
    try {
      await _quoteService.likeQuote(quoteId);
      await fetchUserQuotes(); // Refresh the quotes list
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  // Bookmark a quote
  Future<void> bookmarkQuote(String quoteId) async {
    try {
      await _quoteService.bookmarkQuote(quoteId);
      await fetchUserQuotes(); // Refresh the quotes list
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  void listenToSavedQuotes() {
    _quoteService.getSavedQuotes().listen((data) {
      _savedQuotes = data;
      notifyListeners();
    });
  }

  // Add this method for QuotesScreen
  void listenToCategory(String category) {
    _quoteService.getQuotesForCategory(category).listen((data) {
      _quotes = data;
      notifyListeners();
    });
  }

  // Add this method for DetailQuotes
  Future<void> saveQuote(String id) async {
    await _quoteService.saveQuote(id);
    // Optionally, you can refresh saved quotes here if needed
  }
}
