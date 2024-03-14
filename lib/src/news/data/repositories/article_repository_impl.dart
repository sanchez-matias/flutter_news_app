import 'package:dartz/dartz.dart';
import 'package:flutter_news_app/core/errors/exceptions.dart';
import 'package:flutter_news_app/core/errors/failure.dart';
import 'package:flutter_news_app/core/utils/typedef.dart';
import 'package:flutter_news_app/src/news/data/datasources/article_remote_datasource.dart';
import 'package:flutter_news_app/src/news/domain/entities/article.dart';
import 'package:flutter_news_app/src/news/domain/repositories/article_repository.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final ArticleRemoteDatasource _remoteDatasource;

  const ArticleRepositoryImpl(this._remoteDatasource);

  @override
  ResultFuture<List<Article>> getArticles({
    required String page,
    required String category,
    required String country,
  }) async {
    try {
      return Right(await _remoteDatasource.getArticles(
        page: page,
        category: category,
        country: country,
      ));
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Article>> searchArticles({
    required String query,
    required String searchIn,
    required String language,
  }) async {
    try {
      final result = await _remoteDatasource.searchArticles(
        query: query,
        searchIn: searchIn,
        language: language,
      );
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
}
