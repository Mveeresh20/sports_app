class QuoteCard {
  final String name;
  final String category;
  final String quote;
  final int likes;
  final int bookmarkCount;
  final String imageUrl;
  final String? backgroundImageUrl;

  QuoteCard({
    required this.name,
    required this.category,
    required this.quote,
    required this.likes,
    required this.bookmarkCount,
    required this.imageUrl,
    this.backgroundImageUrl
  });
}