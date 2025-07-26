import 'package:flutter/material.dart';
import '../models/news_article.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  // Static list of news articles as placeholder data
  final List<NewsArticle> _articles = const [
    NewsArticle(
      title: 'National Economy Shows Steady Growth in Q3',
      source: 'National News Agency',
      date: '2023-10-26',
    ),
    NewsArticle(
      title: 'New Advancements in Renewable Energy Unveiled at Summit',
      source: 'Science Today',
      date: '2023-10-26',
    ),
    NewsArticle(
      title: 'Cultural Heritage Sites Receive Increased Protection Status',
      source: 'Ministry of Culture',
      date: '2023-10-25',
    ),
    NewsArticle(
      title: 'Tech Giant Announces Breakthrough in AI Development',
      source: 'Tech Chronicle',
      date: '2023-10-25',
    ),
    NewsArticle(
      title: 'Nationwide Infrastructure Projects Boost Connectivity',
      source: 'Transport Gazette',
      date: '2023-10-24',
    ),
    NewsArticle(
      title: 'Agricultural Sector Reports Bumper Harvest Season',
      source: 'Farmers Daily',
      date: '2023-10-23',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Today\'s China News'),
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
