import 'package:flutter_news_app/core/usecase/usecase.dart';
import 'package:flutter_news_app/core/utils/typedef.dart';
import 'package:flutter_news_app/src/news/domain/entities/article.dart';
import 'package:flutter_news_app/src/news/domain/repositories/article_repository.dart';

class GetArticles extends UseCase<List<Article>, GetArticlesParams> {
  final ArticleRepository _repository;

  const GetArticles(this._repository);

  @override
  ResultFuture<List<Article>> call(GetArticlesParams params) async =>
      _repository.getArticles(
        page: params.page,
        category: params.category,
        country: params.country,
      );
}

class GetArticlesParams {
  final String page;
  final String category;
  final String country;

  GetArticlesParams({
    required this.page,
    required this.category,
    required this.country,
  });
}
