import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/src/news/domain/entities/article.dart';
import 'package:flutter_news_app/src/news/presentation/bloc/remote/remote_articles_bloc.dart';
import 'package:flutter_news_app/src/news/presentation/widgets/article_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  void getArticles() {
    context.read<RemoteArticlesBloc>().add(const GetArticlesEvent());
  }

  @override
  void initState() {
    super.initState();
    getArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<RemoteArticlesBloc, RemoteArticlesState>(
      listener: (context, state) {
        if (state is RemoteArticlesInitial) {
          getArticles();
        }
      },
      builder: (context, state) {
        return switch (state) {
          RemoteArticlesInitial() => const Center(child: CircularProgressIndicator()),

          GettingArticles() => const Center(child: CircularProgressIndicator()),

          ArticlesLoaded() => CardsDisplay(articles: state.articles),

          RequestError() => const ErrorView(),
        };
      },
    ));
  }
}

class CardsDisplay extends StatelessWidget {
  final List<Article> articles;
  const CardsDisplay({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {  
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) => ArticleCard(article: articles[index],),
    );
  }
}

class ErrorView extends StatelessWidget {
  const ErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Text Failed to load articles'),);
  }
}