import 'package:equatable/equatable.dart';
import 'package:flutter_news_app/core/usecase/usecase.dart';
import 'package:flutter_news_app/core/utils/typedef.dart';
import 'package:flutter_news_app/src/news/domain/entities/article.dart';
import 'package:flutter_news_app/src/news/domain/repositories/article_repository.dart';

class GetArticles extends UseCase<List<Article>, CreateArticleParams> {
  final ArticleRepository _repository;

  const GetArticles(this._repository);

  @override
  ResultFuture<List<Article>> call(CreateArticleParams params) async =>
      _repository.getArticles(page: params.page);
}

class CreateArticleParams extends Equatable {
  final int page;

  const CreateArticleParams({required this.page});

  @override
  List<Object?> get props => [page];
}
