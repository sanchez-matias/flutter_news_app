part of 'remote_articles_bloc.dart';

sealed class RemoteArticlesEvent extends Equatable {
  const RemoteArticlesEvent();

  @override
  List<Object> get props => [];
}

class GetArticlesEvent extends RemoteArticlesEvent {
  final int page;

  const GetArticlesEvent({this.page = 1});
}
