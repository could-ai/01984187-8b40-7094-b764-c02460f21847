import 'package:flutter/material.dart';
import '../models/news_article.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  // Static list of news articles as placeholder data for Vietnam
  final List<NewsArticle> _articles = const [
    NewsArticle(
      title: 'Vietnam\'s Economic Growth Surpasses Regional Forecasts',
      source: 'Vietnam News Agency',
      date: '2023-10-26',
    ),
    NewsArticle(
      title: 'Hanoi Launches New Initiative to Preserve Old Quarter',
      source: 'Hanoi Times',
      date: '2023-10-26',
    ),
    NewsArticle(
      title: 'Da Nang Hosts International Tech Conference',
      source: 'Saigon Tech Post',
      date: '2023-10-25',
    ),
    NewsArticle(
      title: 'Vietnamese Coffee Exports See Record Highs This Year',
      source: 'Vietnam Business',
      date: '2023-10-25',
    ),
    NewsArticle(
      title: 'New National Park Established in the Mekong Delta',
      source: 'Ministry of Environment',
      date: '2023-10-24',
    ),
    NewsArticle(
      title: 'Cultural Festival in Hue Attracts Global Tourists',
      source: 'Vietnam Tourism Board',
      date: '2023-10-23',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Today\'s Vietnam News'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: _articles.length,
        itemBuilder: (context, index) {
          final article = _articles[index];
          return Card(
            elevation: 2.0,
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            child: ListTile(
              title: Text(
                article.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('${article.source} - ${article.date}'),
              leading: const Icon(Icons.article),
            ),
          );
        },
      ),
    );
  }
}
