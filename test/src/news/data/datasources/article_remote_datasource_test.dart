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
  });

  group('getArticles', () {
    const testArticles = [ArticleModel.empty()];

    test('should return a [List<ArticleModel>] when the status code is 200',
        () async {
      when(() => client.get(Uri.parse(Urls.articlesByParameters())))
          .thenAnswer((_) async => http.Response(
                jsonEncode([testArticles.first.toMap()]),
                200,
              ));

      final result = await remoteDatasource.getArticles();

      expect(result, isA<List<ArticleModel>>());

      verify(() => client.get(
            Uri.https(Urls.baseUrl, Urls.kGetArticlesEndpoint, {
              'apiKey': Urls.apiKey,
              'country': 'us',
              'category': 'general'
            }),
          )).called(1);

      verifyNoMoreInteractions(client);
    });

    test('should throw [ApiException] when the status code is not 200',
        () async {
      const testMessage = 'SERVER DOWN!';

      when(() => client.get(Uri.parse(Urls.articlesByParameters())))
          .thenAnswer((_) async => http.Response(
                testMessage,
                500,
              ));

      final methodCall = remoteDatasource.getArticles;

      expect(
        () => methodCall(),
        throwsA(const ApiException(messagge: testMessage, statusCode: 500)),
      );

      verify(() => client.get(
            Uri.https(Urls.baseUrl, Urls.kGetArticlesEndpoint, {
              'apiKey': Urls.apiKey,
              'country': 'us',
              'category': 'general'
            }),
          )).called(1);

      verifyNoMoreInteractions(client);
    });
  });

  // TODO: implement tests for searchArticles function.
}
