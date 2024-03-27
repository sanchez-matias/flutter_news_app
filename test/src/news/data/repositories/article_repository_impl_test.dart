// 1) Call the remote datasource
// 2) Check if the method return the proper data
// 3) Make sure that it returns the proper data if it throws no exeption.
// 4) Check if when the remote datasource throws an exception we return the actual expected data.

import 'package:dartz/dartz.dart';
import 'package:flutter_news_app/core/errors/exceptions.dart';
import 'package:flutter_news_app/core/errors/failure.dart';
import 'package:flutter_news_app/src/news/data/datasources/article_remote_datasource.dart';
import 'package:flutter_news_app/src/news/data/repositories/article_repository_impl.dart';
import 'package:flutter_news_app/src/news/domain/entities/article.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockArticlesRemoteDatasource extends Mock
    implements ArticleRemoteDatasource {}

void main() {
  late ArticleRemoteDatasource remoteDatasource;
  late ArticleRepositoryImpl repositoryImpl;

  setUp(() {
    remoteDatasource = MockArticlesRemoteDatasource();
    repositoryImpl = ArticleRepositoryImpl(remoteDatasource);
  });

  const testApiException = ApiException(
    messagge: 'Unknown error occurred',
    statusCode: 500,
  );

  group('getArticles', () {
    const testPage = '100';
    const testCategory = 'politics';
    const testCountry = 'brazil';
    test(
        'should call the [RemoteDatasource.getArticles] and return [List<Articles>] when call'
        'to remote source is successful',
        () async {
      // arrange
      when(
        () => remoteDatasource.getArticles(
          page: any(named: 'page'),
          category: any(named: 'category'),
          country: any(named: 'country'),
        ),
      ).thenAnswer((_) async => []);

      // act
      final result = await repositoryImpl.getArticles(
        page: testPage,
        category: testCategory,
        country: testCountry,
      );

      // assert
      expect(result, isA<Right<dynamic, List<Article>>>());
      verify(() => remoteDatasource.getArticles(
            page: testPage,
            category: testCategory,
            country: testCountry,
          )).called(1);
      verifyNoMoreInteractions(remoteDatasource);
    });

    test(
        'should return an [ApiException] when the remote source is unsuccessful',
        () async {
      when(
        () => remoteDatasource.getArticles(
          page: any(named: 'page'),
          category: any(named: 'category'),
          country: any(named: 'country'),
        ),
      ).thenThrow(testApiException);

      final result = await repositoryImpl.getArticles(
        page: testPage,
        category: testCategory,
        country: testCountry,
      );

      expect(
          result,
          equals(Left<ApiFailure, dynamic>(ApiFailure(
            statusCode: testApiException.statusCode,
            message: testApiException.messagge,
          ))));

      verify(() => remoteDatasource.getArticles(
            page: testPage,
            category: testCategory,
            country: testCountry,
          )).called(1);

      verifyNoMoreInteractions(remoteDatasource);
    });
  });

  group('searchArticles', () {
    const testQuery = 'test';
    const testLanguage = 'language';
    const testSearchIn = 'searchIn';

    test(
        'should call the [RemoteDatasource.searchArticles] and return [List<Articles>] when '
        'call to remote source is successful',
        () async {
      when(() => remoteDatasource.searchArticles(
            query: testQuery,
            language: testLanguage,
            searchIn: testSearchIn,
          )).thenAnswer((_) async => []);

      final result = await repositoryImpl.searchArticles(
        query: testQuery,
        language: testLanguage,
        searchIn: testSearchIn,
      );

      expect(result, isA<Right<dynamic, List<Article>>>());

      verify(() => remoteDatasource.searchArticles(
            query: testQuery,
            language: testLanguage,
            searchIn: testSearchIn,
          )).called(1);

      verifyNoMoreInteractions(remoteDatasource);
    });

    test(
        'should return an [ApiException] when the remote source is unsuccessful',
        () async {
      when(() => remoteDatasource.searchArticles(
            query: testQuery,
            language: testLanguage,
            searchIn: testSearchIn,
          )).thenThrow(testApiException);

      final result = await repositoryImpl.searchArticles(
        query: testQuery,
        language: testLanguage,
        searchIn: testSearchIn,
      );

      expect(result, equals(Left(ApiFailure.fromException(testApiException))));

      verify(() => remoteDatasource.searchArticles(
            query: testQuery,
            language: testLanguage,
            searchIn: testSearchIn,
          )).called(1);

      verifyNoMoreInteractions(remoteDatasource);
    });
  });
}
