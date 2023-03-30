import 'package:dicoding_flutter_news/data/api/api_service.dart';
import 'package:dicoding_flutter_news/data/model/article.dart';
import 'package:dicoding_flutter_news/ui/news_detail_page.dart';
import 'package:flutter/material.dart';

class NewsListPage extends StatefulWidget {
  static const routeName = '/article_list';

  const NewsListPage({super.key});

  @override
  State<NewsListPage> createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  late Future<ArticlesResult> _articles;

  @override
  void initState() {
    _articles = ApiService().getTopHeadlines();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
      ),
      body: FutureBuilder(
        future: _articles,
        builder: (context, AsyncSnapshot<ArticlesResult> snapshot) {
          var state = snapshot.connectionState;
          if (state != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasData) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data?.articles.length,
                itemBuilder: (context, index) {
                  return _buildArticleItem(
                      context, snapshot.data!.articles[index]);
                },
              );
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else {
              return const Center(child: Text('Unknown error'));
            }
          }
        },
      ),
    );
  }

  Widget _buildArticleItem(BuildContext context, Article article) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: article.urlToImage == null
          ? const SizedBox(
              width: 100,
              child: Icon(Icons.error),
            )
          : Image.network(
              article.urlToImage!,
              width: 100,
            ),
      title: Text(article.title),
      subtitle: Text(article.author ?? "Unknown Author"),
      onTap: () {
        Navigator.pushNamed(
          context,
          NewsDetailPage.routeName,
          arguments: article,
        );
      },
    );
  }
}
