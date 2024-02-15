import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_news_app/core/errors/failure.dart';
import 'package:flutter_news_app/src/news/domain/usecases/get_articles.dart';
import 'package:flutter_news_app/src/news/domain/usecases/search_articles.dart';
import 'package:flutter_news_app/src/news/presentation/bloc/remote/remote_articles_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetArticles extends Mock implements GetArticles {}

class MockSearchArticles extends Mock implements SearchArticles {}

void main() {
  group('RemoteArticlesBloc', () {
    late GetArticles getArticles;
    late SearchArticles searchArticles;

    const testApiFailure =
        ApiFailure(statusCode: 400, message: 'Test Failed Successfully');

    const testQuery = 'Batman';

    setUp(() {
      getArticles = MockGetArticles();
      searchArticles = MockSearchArticles();
    });

    test('initial state is [RemoteArticlesInitial]', () {
      expect(
          RemoteArticlesBloc(
            getArticles: getArticles,
            searchArticles: searchArticles,
          ).state,
          const RemoteArticlesInitial());
    });

    blocTest<RemoteArticlesBloc, RemoteArticlesState>(
        'emits [GettingArticles, ArticlesLoaded] articles are loaded successfully',
        setUp: () {
          when(() => getArticles(any()))
              .thenAnswer((_) async => const Right([]));
        },
        build: () => RemoteArticlesBloc(
            getArticles: getArticles, searchArticles: searchArticles),
        act: (bloc) => bloc.add(const GetArticlesEvent(page: 2)),
        expect: () => <RemoteArticlesState>[
              const GettingArticles(),
              const ArticlesLoaded([]),
            ],
        verify: (_) {
          verify(() => getArticles(2)).called(1);
          verifyNoMoreInteractions(getArticles);
        });

    blocTest<RemoteArticlesBloc, RemoteArticlesState>(
      'emits [GettingArticles, ArticlesError] when articles loading is unsuccessful',
      setUp: () {
        when(() => getArticles(any()))
            .thenAnswer((_) async => const Left(testApiFailure));
      },
      build: () => RemoteArticlesBloc(
          getArticles: getArticles, searchArticles: searchArticles),
      act: (bloc) => bloc.add(const GetArticlesEvent(page: 2)),
      expect: () => <RemoteArticlesState>[
        const GettingArticles(),
        ArticlesError(testApiFailure.errorMessage),
      ],
      verify: (_) {
        verify(() => getArticles(2)).called(1);
        verifyNoMoreInteractions(getArticles);
      },
    );

    blocTest<RemoteArticlesBloc, RemoteArticlesState>(
      'emits [SearchingArticles, SearchArticlesFinished] when article search is successfull',
      setUp: () {
        when(() => searchArticles(any()))
            .thenAnswer((_) async => const Right([]));
      },
      build: () => RemoteArticlesBloc(
          getArticles: getArticles, searchArticles: searchArticles),
      act: (bloc) => bloc.add(const SearchArticlesEvent(testQuery)),
      expect: () => <RemoteArticlesState>[
        const SearchingArticles(),
        const SearchArticlesFinished([]),
      ],
      verify: (_) {
        verify(() => searchArticles(testQuery)).called(1);
        verifyNoMoreInteractions(searchArticles);
      },
    );

    blocTest(
      'emits [SearchingArticles, ArticlesError] when article search is unsuccessful',
      setUp: () {
        when(() => searchArticles(any())).thenAnswer((invocation) async => const Left(testApiFailure));
      },
      build: () => RemoteArticlesBloc(getArticles: getArticles, searchArticles: searchArticles),
      act: (bloc) => bloc.add(const SearchArticlesEvent(testQuery)),
      expect: () => <RemoteArticlesState>[
        const SearchingArticles(),
        ArticlesError(testApiFailure.errorMessage),
      ],
      verify: (bloc) {
        verify(() => searchArticles(testQuery)).called(1);
        verifyNoMoreInteractions(searchArticles);
      },
    );
  });
}
