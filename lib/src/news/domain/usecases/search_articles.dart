import 'package:flutter_news_app/core/usecase/usecase.dart';
import 'package:flutter_news_app/core/utils/typedef.dart';
import 'package:flutter_news_app/src/news/domain/entities/article.dart';
import 'package:flutter_news_app/src/news/domain/repositories/article_repository.dart';

class SearchArticles extends UseCase<List<Article>, SearchArticlesParams> {
  final ArticleRepository _repository;

  const SearchArticles(this._repository);

  @override
  ResultFuture<List<Article>> call(SearchArticlesParams params) async =>
      _repository.searchArticles(
        query: params.query,
        searchIn: params.searchIn,
        language: params.language,
      );
}

class SearchArticlesParams {
  final String query;
  final String searchIn;
  final String language;

  SearchArticlesParams({
    required this.query,
    required this.searchIn,
    required this.language,
  });
}
