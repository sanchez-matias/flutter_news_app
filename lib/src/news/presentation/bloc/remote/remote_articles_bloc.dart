import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_news_app/src/news/domain/usecases/get_articles.dart';

import '../../../domain/entities/article.dart';

part 'remote_articles_event.dart';
part 'remote_articles_state.dart';

class HomeBloc extends RemoteArticlesBloc {
  HomeBloc({required super.getArticles});
}

class CategoryBloc extends RemoteArticlesBloc {
  CategoryBloc({required super.getArticles});
}

class RemoteArticlesBloc
    extends Bloc<RemoteArticlesEvent, RemoteArticlesState> {
  final GetArticles _getArticles;

  RemoteArticlesBloc({
    required GetArticles getArticles,
  })  : _getArticles = getArticles,
        super(const RemoteArticlesState()) {
    on<GetArticlesEvent>(_getArticlesHandler);
  }

  Future<void> _getArticlesHandler(
    GetArticlesEvent event,
    Emitter<RemoteArticlesState> emit,
  ) async {
    emit(state.copyWith(status: RequestStatus.gettingArticles));

    final result = await _getArticles(GetArticlesParams(
      page: event.page,
      category: event.category,
      country: event.country,
    ));

    result.fold(
      (failure) => emit(state.copyWith(
        status: RequestStatus.error,
        message: failure.errorMessage,
      )),
      (articles) => emit(state.copyWith(
        status: RequestStatus.articlesLoaded,
        articles: articles,
      )),
    );
  }
}
