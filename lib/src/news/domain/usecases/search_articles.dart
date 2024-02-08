import 'package:flutter_news_app/core/usecase/usecase.dart';
import 'package:flutter_news_app/core/utils/typedef.dart';
import 'package:flutter_news_app/src/news/domain/entities/article.dart';
import 'package:flutter_news_app/src/news/domain/repositories/article_repository.dart';

class SearchArticles extends UseCase<List<Article>, String> {
  final ArticleRepository _repository;

  const SearchArticles(this._repository);

  @override
  ResultFuture<List<Article>> call(String params) async =>
      _repository.searchArticles(params);
}

