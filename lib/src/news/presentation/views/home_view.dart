import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/src/news/presentation/bloc/remote/remote_articles_bloc.dart';
import 'package:flutter_news_app/src/news/presentation/widgets/widgets.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with AutomaticKeepAliveClientMixin {
  void getArticles({
    int page = 0,
    String category = 'general',
    String country = 'us',
  }) {
    context.read<HomeBloc>().add(GetArticlesEvent(
          page: page.toString(),
          category: category,
          country: country,
        ));
  }

  @override
  void initState() {
    super.initState();
    getArticles();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<HomeBloc, RemoteArticlesState>(
      listener: (context, state) {
        if (state.status == RequestStatus.initial) {
          getArticles();
        }
      },
      builder: (context, state) {
        return switch (state.status) {
          RequestStatus.initial =>
            const Center(child: CircularProgressIndicator()),
          RequestStatus.gettingArticles =>
            const Center(child: CircularProgressIndicator()),
          RequestStatus.articlesLoaded => CardsScroll(articles: state.articles),
          RequestStatus.error => const ErrorView(),
        };
      },
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}
