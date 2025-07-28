class NewsArticle {
  final String title;
  final String? source; // Make nullable
  final String? date;   // Make nullable
  final String url;     // Add URL for the full article

  const NewsArticle({
    required this.title,
    required this.url,
    this.source,
    this.date,
  });
}
