import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_bloc/constant/api_key.dart';
import 'package:news_bloc/models/article_model.dart';

class ApiService {
  final endPointUrl =
      'http://newsapi.org/v2/everything?domains=wsj.com&apiKey=$yourApiKey';
  Future<List<Article>> getArticle() async {
    final response = await http.get(Uri.parse(endPointUrl));

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);

      List<dynamic> body = json['articles'];

      List<Article> articles =
          body.map((dynamic item) => Article.fromJson(item)).toList();

      return articles;
    } else {
      throw ("Falha em carregar os artigos");
    }
  }
}
