import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/src/news/presentation/bloc/remote/remote_articles_bloc.dart';
import 'package:flutter_news_app/src/news/presentation/widgets/widgets.dart';

class CategoryScreen extends StatefulWidget {
  final String categoryName;

  const CategoryScreen({
    super.key,
    required this.categoryName,
  });

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  void getArticles({
    int page = 0,
    required String category,
    String country = 'us',
  }) {
    context.read<CategoryBloc>().add(GetArticlesEvent(
          page: page.toString(),
          category: category,
          country: country,
        ));
  }

  @override
  void initState() {
    super.initState();
    getArticles(category: widget.categoryName.toLowerCase());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryBloc, RemoteArticlesState>(
        listener: (context, state) {
          if (state.status == RequestStatus.initial) {
            getArticles(category: widget.categoryName.toLowerCase());
          }
        },
        builder: (context, state) => Scaffold(
            appBar: AppBar(
              title: Text(widget.categoryName),
            ),
            body: switch (state.status) {
              RequestStatus.initial =>
                const Center(child: CircularProgressIndicator()),
              RequestStatus.gettingArticles =>
                const Center(child: CircularProgressIndicator()),
              RequestStatus.articlesLoaded =>
                CardsScroll(articles: state.articles),
              RequestStatus.error => const ErrorView(),
            }));
  }
}
