import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_news_app/src/news/domain/usecases/get_articles.dart';

import '../../../domain/entities/article.dart';

part 'remote_articles_event.dart';
part 'remote_articles_state.dart';

class RemoteArticlesBloc
    extends Bloc<RemoteArticlesEvent, RemoteArticlesState> {
  final GetArticles _getArticles;

  RemoteArticlesBloc({
    required GetArticles getArticles,
  })  : _getArticles = getArticles,
        super(const RemoteArticlesInitial()) {
    on<GetArticlesEvent>(_getArticlesHandler);
  }

  Future<void> _getArticlesHandler(
    GetArticlesEvent event,
    Emitter<RemoteArticlesState> emit,
  ) async {
    emit(const GettingArticles());

    final result = await _getArticles(event.page);

    result.fold(
      (failure) => emit(RequestError(failure.errorMessage)),
      (articles) => emit(ArticlesLoaded(articles)),
    );
  }
}
