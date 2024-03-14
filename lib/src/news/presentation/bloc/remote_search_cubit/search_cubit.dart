import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_news_app/src/news/domain/usecases/search_articles.dart';

import '../../../domain/entities/article.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchArticles _searchArticles;

  SearchCubit(SearchArticles searchArticles)
      : _searchArticles = searchArticles,
        super(SearchInitial());

  Future<void> searchArticles({
    required String query,
    required String searchIn,
    required String language,
  }) async {
    emit(const Searching());

    final result = await _searchArticles(SearchArticlesParams(
      query: query,
      searchIn: searchIn,
      language: language,
    ));

    result.fold(
      (failure) => emit(SearchingError(failure.errorMessage)),
      (articles) => emit(SearchingSuccess(articles)),
    );
  }
}
