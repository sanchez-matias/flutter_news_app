import 'package:dartz/dartz.dart';
import 'package:flutter_news_app/src/news/domain/entities/article.dart';
import 'package:flutter_news_app/src/news/domain/repositories/article_repository.dart';
import 'package:flutter_news_app/src/news/domain/usecases/get_articles.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockArticlesRepo extends Mock implements ArticleRepository {}

void main() {
  late GetArticles usecase;
  late ArticleRepository repository;

  setUp(() {
    repository = MockArticlesRepo();
    usecase = GetArticles(repository);
  });

  const testResponse = [Article.empty()];
  const testPage = '100';
  const testCategory = 'politics';
  const testCountry = 'us';

  test(
    'should call the [ArticleRepository.createUser]',
    () async {
      // Arrange
      when(() => repository.getArticles(
            page: testPage,
            category: testCategory,
            country: testCountry,
          )).thenAnswer(
        (_) async => const Right(testResponse),
      );

      // Act
      final result = await usecase(GetArticlesParams(
        page: testPage,
        category: testCategory,
        country: testCountry,
      ));

      // Assert
      expect(result, equals(const Right<dynamic, List<Article>>(testResponse)));

      verify(() => repository.getArticles(
            page: testPage,
            category: testCategory,
            country: testCountry,
          )).called(1);

      verifyNoMoreInteractions(repository);
    },
  );
}
