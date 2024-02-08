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
  ResultFuture<List<Article>> getArticles({int page = 1}) async {
    try {
      return Right(await _remoteDatasource.getArticles(page: page));
      

    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Article>> searchArticles(String query) async {
    try {
      final result = await _remoteDatasource.searchArticles(query);
      return Right(result);

    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
}
