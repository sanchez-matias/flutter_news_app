import 'dart:convert';
import 'package:flutter_news_app/core/errors/exceptions.dart';
import 'package:flutter_news_app/core/utils/constants.dart';
import 'package:flutter_news_app/src/news/data/models/article_model.dart';
import 'package:http/http.dart' as http;

abstract class ArticleRemoteDatasource {
  Future<List<ArticleModel>> getArticles({int page = 1});

  Future<List<ArticleModel>> searchArticles(String query);
}

class ArticleRemoteDatasourceImpl implements ArticleRemoteDatasource {
  final http.Client _client;

  ArticleRemoteDatasourceImpl(this._client);

  @override
  Future<List<ArticleModel>> getArticles({int page = 1}) async {
    try {
      final response =
          await _client.get(Uri.parse(Urls.articlesByParameters()));
      
      if (response.statusCode != 200) {
        throw ApiException(messagge: response.body, statusCode: response.statusCode);
      }

      return List<Map<String, dynamic>>.from(jsonDecode(response.body) as List)
          .map((articleData) => ArticleModel.fromMap(articleData))
          .toList();

    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(messagge: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<List<ArticleModel>> searchArticles(String query) async {
    // TODO: implement searchArticles
    throw UnimplementedError();
  }
}
