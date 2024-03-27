import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_news_app/core/errors/failure.dart';
import 'package:flutter_news_app/src/news/domain/usecases/search_articles.dart';
import 'package:flutter_news_app/src/news/presentation/bloc/remote_search_cubit/search_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSearchArticles extends Mock implements SearchArticles {}

void main() {
  group('SearchArticlesCubit', () {
    late SearchArticles searchArticles;

    const testApiFailure = ApiFailure(
      statusCode: 400,
      message: 'Search Test Failed Successfully',
    );

    setUp(() {
      searchArticles = MockSearchArticles();
      registerFallbackValue(SearchArticlesParams(
        query: 'query',
        searchIn: 'searchIn',
        language: 'language',
      ));
    });

    test('initial state is [SearchInitial]', () {
      expect(SearchCubit(searchArticles).state, SearchInitial());
    });

    blocTest<SearchCubit, SearchState>(
      'emits [Searching, SearchingSuccess] when articles are loaded successfully',
      setUp: () => when(() => searchArticles(any()))
          .thenAnswer((_) async => const Right([])),
      build: () => SearchCubit(searchArticles),
      act: (bloc) => bloc.searchArticles(
          query: 'query', searchIn: 'searchIn', language: 'language'),
      expect: () =>
          <SearchState>[const Searching(), const SearchingSuccess([])],
      verify: (_) {
        verify(() => searchArticles(any())).called(1);
        verifyNoMoreInteractions(searchArticles);
      },
    );

    blocTest<SearchCubit, SearchState>(
      'emits [GettingArticles, ArticlesError] when articles loading is unsuccessful',
      setUp: () {
        when(() => searchArticles(any()))
            .thenAnswer((_) async => const Left(testApiFailure));
      },
      build: () => SearchCubit(searchArticles),
      act: (bloc) => bloc.searchArticles(query: 'query', searchIn: 'searchIn', language: 'language'),
      expect: () => <SearchState>[
        const Searching(),
        SearchingError(testApiFailure.errorMessage)
      ],
      verify: (_) {
        verify(() => searchArticles(any())).called(1);
        verifyNoMoreInteractions(searchArticles);
      },
    );

  });
}
