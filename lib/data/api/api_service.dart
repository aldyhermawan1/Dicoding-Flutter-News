import 'dart:convert';

import 'package:http/http.dart' as http;
import '../model/article.dart';

class ApiService {
  static const _baseUrl = 'https://newsapi.org/v2/';
  static const _apiKey = 'ded48df3695c4c7cb12e7f26f5c998b0';
  static const _category = 'technology';
  static const _country = 'us';

  Future<ArticlesResult> getTopHeadlines() async {
    final response = await http.get(Uri.parse(
        "${_baseUrl}top-headlines?country=$_country&category=$_category&apiKey=$_apiKey"));
    if (response.statusCode == 200) {
      return ArticlesResult.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Top Headlines');
    }
  }
}
