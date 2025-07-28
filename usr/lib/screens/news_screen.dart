import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:html/parser.dart' as html_parser;
import '../models/news_article.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  bool _isLoading = true;
  List<NewsArticle> _articles = [];

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  Future<void> _fetchNews() async {
    final dio = Dio();
    // Target a specific section of the news site for more consistent results
    const url = 'https://vnexpress.net/the-gioi';

    try {
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        final document = html_parser.parse(response.data);
        // This selector targets article headlines within the main content area
        final articlesElements = document.querySelectorAll('h3.title-news a');

        final List<NewsArticle> fetchedArticles = [];
        for (var element in articlesElements) {
          final title = element.attributes['title'];
          final articleUrl = element.attributes['href'];

          if (title != null && articleUrl != null && !fetchedArticles.any((a) => a.title == title)) {
            fetchedArticles.add(
              NewsArticle(
                title: title,
                url: articleUrl,
                source: 'VnExpress', // Set a default source
              ),
            );
          }
        }
        setState(() {
          _articles = fetchedArticles;
          _isLoading = false;
        });
      } else {
        // Handle server errors
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      // Handle network exceptions
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Today\'s Vietnam News'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _articles.isEmpty
              ? const Center(
                  child: Text(
                    'Failed to load news or no articles found.',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                )
              : ListView.builder(
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
                        subtitle: Text(article.source ?? 'No source'),
                        leading: const Icon(Icons.article),
                        onTap: () {
                          // A great next step would be to use the url_launcher package
                          // to open the article.url in a web browser.
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Article URL: ${article.url}')),
                          );
                        },
                      ),
                    );
                  },
                ),
    );
  }
}
