import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_news_app/core/errors/failure.dart';
import 'package:flutter_news_app/src/news/domain/usecases/get_articles.dart';
import 'package:flutter_news_app/src/news/presentation/bloc/remote/remote_articles_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetArticles extends Mock implements GetArticles {}

void main() {
  group('RemoteArticlesBloc', () {
    late GetArticles getArticles;

    const testApiFailure = ApiFailure(
      statusCode: 400,
      message: 'Get Test Failed Successfully',
    );

    setUp(() {
      getArticles = MockGetArticles();
      registerFallbackValue(GetArticlesParams(page: '2', category: 'general', country: 'ar'));
    });

    test('initial state is [RemoteArticlesInitial]', () {
      expect(
          RemoteArticlesBloc(
            getArticles: getArticles,
          ).state,
          const RemoteArticlesState(status: RequestStatus.initial));
    });

    blocTest<RemoteArticlesBloc, RemoteArticlesState>(
        'emits [GettingArticles, ArticlesLoaded] articles are loaded successfully',
        setUp: () {
          when(() => getArticles(any()))
              .thenAnswer((_) async => const Right([]));
        },
        build: () => RemoteArticlesBloc(getArticles: getArticles),
        act: (bloc) => bloc.add(const GetArticlesEvent(
            page: '2', category: 'general', country: 'us')),
        expect: () => <RemoteArticlesState>[
              const RemoteArticlesState(status: RequestStatus.gettingArticles),
              const RemoteArticlesState(
                  status: RequestStatus.articlesLoaded, articles: []),
            ],
        verify: (_) {
          verify(() => getArticles(any())).called(1);
          verifyNoMoreInteractions(getArticles);
        });

    blocTest<RemoteArticlesBloc, RemoteArticlesState>(
      'emits [GettingArticles, ArticlesError] when articles loading is unsuccessful',
      setUp: () {
        when(() => getArticles(any()))
            .thenAnswer((_) async => const Left(testApiFailure));
      },
      build: () => RemoteArticlesBloc(getArticles: getArticles),
      act: (bloc) => bloc.add(const GetArticlesEvent(
          page: '2', category: 'general', country: 'us')),
      expect: () => <RemoteArticlesState>[
        const RemoteArticlesState(status: RequestStatus.gettingArticles),
        RemoteArticlesState(status: RequestStatus.error, message: testApiFailure.errorMessage)
      ],
      verify: (_) {
        verify(() => getArticles(any())).called(1);
        verifyNoMoreInteractions(getArticles);
      },
    );
  });
}
