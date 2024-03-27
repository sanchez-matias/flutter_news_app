import 'dart:convert';
import 'package:flutter_news_app/core/errors/exceptions.dart';
import 'package:flutter_news_app/core/utils/constants.dart';
import 'package:flutter_news_app/src/news/data/datasources/article_remote_datasource.dart';
import 'package:flutter_news_app/src/news/data/models/article_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late ArticleRemoteDatasource remoteDatasource;

  // final methodCall = remoteDatasource.getArticles;

  setUp(() {
    client = MockClient();
    remoteDatasource = ArticleRemoteDatasourceImpl(client);
    registerFallbackValue(Uri.https(Urls.baseUrl, Urls.kGetArticlesEndpoint));
  });

  const testArticles = ArticleModel.empty();

  group('getArticles', () {
    const testPage = '100';
    const testCountry = 'bolivia';
    const testCategory = 'politics';

    test('should return a [List<ArticleModel>] when the status code is 200',
        () async {
      when(() => client.get(any())).thenAnswer((_) async => http.Response(
            jsonEncode({
              "articles": [testArticles.toMap()]
            }),
            200,
          ));

      final result = await remoteDatasource.getArticles(
        country: testCountry,
        category: testCategory,
        page: testPage,
      );

      expect(result, equals([testArticles]));

      verify(() => client.get(
            Uri.https(Urls.baseUrl, Urls.kGetArticlesEndpoint, {
              'apiKey': Urls.apiKey,
              'category': testCategory,
              'country': testCountry,
              'page': testPage,
            }),
          )).called(1);

      verifyNoMoreInteractions(client);
    });

    test('should throw [ApiException] when the status code is not 200',
        () async {
      const testMessage = 'SERVER DOWN!';

      when(() => client.get(any())).thenAnswer((_) async => http.Response(
            testMessage,
            500,
          ));

      final methodCall = remoteDatasource.getArticles;

      expect(
        () async => methodCall(
            page: testPage, category: testCategory, country: testCountry),
        throwsA(const ApiException(messagge: testMessage, statusCode: 500)),
      );

      verify(() => client.get(
            Uri.https(Urls.baseUrl, Urls.kGetArticlesEndpoint, {
              'apiKey': Urls.apiKey,
              'category': testCategory,
              'country': testCountry,
              'page': testPage
            }),
          )).called(1);

      verifyNoMoreInteractions(client);
    });
  });

  group('searchArticles', () {
    const testQuery = 'obama';
    const testSearchIn = 'filters';
    const testLanguage = 'polish';

    test('should return a [List<ArticeModel>] when status code is 200',
        () async {
      when(() => client.get(any()))
          .thenAnswer((invocation) async => http.Response(
              jsonEncode({
                "articles": [testArticles.toMap()]
              }),
              200));

      final result = await remoteDatasource.searchArticles(
        query: testQuery,
        searchIn: testSearchIn,
        language: testLanguage,
      );

      expect(result, equals([testArticles]));

      verify(
        () => client.get(Uri.https(Urls.baseUrl, Urls.kSearchArticlesEndpoint, {
          'apiKey': Urls.apiKey,
          'q': testQuery,
          'searchIn': testSearchIn,
          'language': testLanguage,
        })),
      ).called(1);

      verifyNoMoreInteractions(client);
    });

    test('should throw a [ApiException] when status code is not 200', () async {
      when(() => client.get(any())).thenAnswer((_) async => http.Response(
            'ApiException thrown!',
            500,
          ));

      final methodCall = remoteDatasource.searchArticles;

      expect(
        () => methodCall(
          query: testQuery,
          searchIn: testSearchIn,
          language: testLanguage,
        ),
        throwsA(const ApiException(
            messagge: 'ApiException thrown!', statusCode: 500)),
      );

      verify(
        () => client.get(Uri.https(Urls.baseUrl, Urls.kSearchArticlesEndpoint, {
          'apiKey': Urls.apiKey,
          'q': testQuery,
          'searchIn': testSearchIn,
          'language': testLanguage,
        })),
      ).called(1);

      verifyNoMoreInteractions(client);
    });
  });
}
