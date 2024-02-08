import 'dart:convert';
import 'package:flutter_news_app/src/news/data/models/article_model.dart';
import 'package:flutter_news_app/src/news/domain/entities/article.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const testModel = ArticleModel.empty();

  test('should be a subclass of [Article] entity', () {
    // Arrange is no needed because all we need here is the test model.
    // Act is no needed because there's no external functions to call.

    // Assert
    expect(testModel, isA<Article>());
  });

  final testJson = fixture('article.json');
  final testMap = jsonDecode(testJson) as Map<String, dynamic>;

  group('fromMap', () {
    test('should return an [ArticleModel] with the right data', () {
      final result = ArticleModel.fromMap(testMap);
      expect(result, equals(testModel));
    });
  });

  group('fromJson', () {
    test('sould return an [ArticleModel] with the right data', () {
      final result = ArticleModel.fromJson(testJson);
      expect(result, equals(testModel));
    });
  });

  group('toMap', () {
    test('return a [Map] with the right data', () {
      final result = testModel.toMap();
      expect(result, equals(testMap));
    });
  });

  group('copyWith', () {
    test('should return a [UserModel] with different data', () {
      final result = testModel.copyWith(content: 'Censored Content');
      expect(result.content, equals('Censored Content'));
    });
  });
}
