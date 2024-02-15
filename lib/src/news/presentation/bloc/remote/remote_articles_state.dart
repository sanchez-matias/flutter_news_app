part of 'remote_articles_bloc.dart';

sealed class RemoteArticlesState extends Equatable {
  const RemoteArticlesState();

  @override
  List<Object?> get props => [];
}

class RemoteArticlesInitial extends RemoteArticlesState {
  const RemoteArticlesInitial();
}

class GettingArticles extends RemoteArticlesState {
  const GettingArticles();
}

class SearchingArticles extends RemoteArticlesState {
  const SearchingArticles();
}

class ArticlesLoaded extends RemoteArticlesState {
  final List<Article> articles;

  const ArticlesLoaded(this.articles);

  @override
  List<Object?> get props => articles.map((article) => article.url).toList();
}

class SearchArticlesFinished extends RemoteArticlesState {
  final List<Article> articles;

  const SearchArticlesFinished(this.articles);

  @override
  List<Object?> get props => articles.map((article) => article.url).toList();
}

class ArticlesError extends RemoteArticlesState {
  final String message;

  const ArticlesError(this.message);

  @override
  List<String> get props => [message];
}