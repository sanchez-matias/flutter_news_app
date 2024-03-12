part of 'remote_articles_bloc.dart';

sealed class RemoteArticlesEvent extends Equatable {
  const RemoteArticlesEvent();

  @override
  List<Object> get props => [];
}

class GetArticlesEvent extends RemoteArticlesEvent {
  final String page;
  final String category;
  final String country;

  const GetArticlesEvent({
    required this.page,
    required this.category,
    required this.country,
  });
}
