import 'package:flutter_news_app/src/news/data/datasources/article_remote_datasource.dart';
import 'package:flutter_news_app/src/news/data/repositories/article_repository_impl.dart';
import 'package:flutter_news_app/src/news/domain/repositories/article_repository.dart';
import 'package:flutter_news_app/src/news/domain/usecases/get_articles.dart';
import 'package:flutter_news_app/src/news/domain/usecases/search_articles.dart';
import 'package:flutter_news_app/src/news/presentation/bloc/remote/remote_articles_bloc.dart';
import 'package:flutter_news_app/src/news/presentation/bloc/remote_search_cubit/search_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  sl
    // App logic
    ..registerFactory(() => RemoteArticlesBloc(getArticles: sl()))
    ..registerFactory(() => SearchCubit(sl()))

    // Usecases
    ..registerLazySingleton(() => GetArticles(sl()))
    ..registerLazySingleton(() => SearchArticles(sl()))

    // Repositories
    ..registerLazySingleton<ArticleRepository>(() => ArticleRepositoryImpl(sl()))

    // Datasources
    ..registerLazySingleton<ArticleRemoteDatasource >(() => ArticleRemoteDatasourceImpl(sl()))

    // External dependencies
    ..registerLazySingleton(http.Client.new);

}
