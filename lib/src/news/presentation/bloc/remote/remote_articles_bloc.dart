import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_news_app/src/news/domain/usecases/get_articles.dart';
import 'package:flutter_news_app/src/news/domain/usecases/search_articles.dart';

import '../../../domain/entities/article.dart';

part 'remote_articles_event.dart';
part 'remote_articles_state.dart';

class RemoteArticlesBloc
    extends Bloc<RemoteArticlesEvent, RemoteArticlesState> {
  final GetArticles _getArticles;
  final SearchArticles _searchArticles;

  RemoteArticlesBloc({
    required GetArticles getArticles,
    required SearchArticles searchArticles,
  })  : _getArticles = getArticles,
        _searchArticles = searchArticles,
        super(const RemoteArticlesInitial()) {
    on<GetArticlesEvent>(_getArticlesHandler);
    on<SearchArticlesEvent>(_searchArticleHandler);
  }

  Future<void> _getArticlesHandler(
    GetArticlesEvent event,
    Emitter<RemoteArticlesState> emit,
  ) async {
    emit(const GettingArticles());

    final result = await _getArticles(event.page);

    result.fold(
      (failure) => emit(ArticlesError(failure.errorMessage)),
      (articles) => emit(ArticlesLoaded(articles)),
    );
  }

  Future<void> _searchArticleHandler(
    SearchArticlesEvent event,
    Emitter<RemoteArticlesState> emit,
  ) async {
    emit(const SearchingArticles());

    final result = await _searchArticles(event.query);

    result.fold(
      (failure) => emit(ArticlesError(failure.errorMessage)),
      (articles) => emit(SearchArticlesFinished(articles)),
    );
  }
}
