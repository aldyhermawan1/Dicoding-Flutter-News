import 'package:dicoding_flutter_news/article.dart';
import 'package:dicoding_flutter_news/news_detail_page.dart';
import 'package:dicoding_flutter_news/news_webview.dart';
import 'package:flutter/material.dart';

import 'news_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: NewsListPage.routeName,
      routes: {
        NewsListPage.routeName: (context) => const NewsListPage(),
        NewsDetailPage.routeName: (context) => NewsDetailPage(
            article: ModalRoute.of(context)?.settings.arguments as Article),
        NewsWebView.routeName: (context) => NewsWebView(
            url: ModalRoute.of(context)?.settings.arguments as String),
      },
    );
  }
}
