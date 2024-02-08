import 'package:dartz/dartz.dart';
import 'package:flutter_news_app/src/news/domain/entities/article.dart';
import 'package:flutter_news_app/src/news/domain/repositories/article_repository.dart';
import 'package:flutter_news_app/src/news/domain/usecases/search_articles.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockArticlesRepo extends Mock implements ArticleRepository {}

void main() {
  late ArticleRepository repository;
  late SearchArticles usecase;

  setUp(() {
    repository = MockArticlesRepo();
    usecase = SearchArticles(repository);
  });

  const testResponse = [Article.empty()];
  const testQuery = 'SEARCH_TEST_QUERY';

  test(
      'should call [ArticlesRepository.searchArticles] and return [List<Article>]',
      () async {
    when(
      () => repository.searchArticles(testQuery),
    ).thenAnswer((_) async => const Right(testResponse));

    final result = await usecase(testQuery);

    expect(result, equals(const Right<dynamic, List<Article>>(testResponse)));

    verify(() => repository.searchArticles(testQuery)).called(1);

    verifyNoMoreInteractions(repository);
  });
}
