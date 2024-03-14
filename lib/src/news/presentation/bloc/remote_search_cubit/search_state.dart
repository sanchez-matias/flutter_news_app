part of 'search_cubit.dart';

class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

final class SearchInitial extends SearchState {}

class Searching extends SearchState {
  const Searching();
}

class SearchingSuccess extends SearchState {
  final List<Article> articles;
  const SearchingSuccess(this.articles);

  @override
  List<Object?> get props => articles.map((e) => e.title).toList();
}

class SearchingError extends SearchState {
  final String? message;
  const SearchingError(this.message);

  @override
  List<Object?> get props => [message];
}
