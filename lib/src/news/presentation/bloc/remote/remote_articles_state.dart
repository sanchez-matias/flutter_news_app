part of 'remote_articles_bloc.dart';

enum RequestStatus { initial, gettingArticles, articlesLoaded, error }

class RemoteArticlesState extends Equatable {
  final RequestStatus status;
  final List<Article> articles;
  final String? message;

  const RemoteArticlesState({
    this.status = RequestStatus.initial,
    this.articles = const [],
    this.message,
  });

  RemoteArticlesState copyWith({
    RequestStatus? status,
    List<Article>? articles,
    String? message,
  }) =>
      RemoteArticlesState(
        status: status ?? this.status,
        articles: articles ?? this.articles,
        message: message ?? this.message,
      );

  @override
  List<Object?> get props => [status, articles];
}
