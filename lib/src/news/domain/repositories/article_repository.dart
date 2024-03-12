import 'package:flutter_news_app/core/utils/typedef.dart';
import 'package:flutter_news_app/src/news/domain/entities/article.dart';

abstract class ArticleRepository {
  const ArticleRepository();

  ResultFuture<List<Article>> getArticles({
    required String page,
    required String category,
    required String country,
  });

  ResultFuture<List<Article>> searchArticles(String query);
}
