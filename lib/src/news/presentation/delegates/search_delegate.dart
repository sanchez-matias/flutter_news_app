import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/src/news/presentation/bloc/remote_search_cubit/search_cubit.dart';
import 'package:flutter_news_app/src/news/presentation/widgets/widgets.dart';

class SearchArticleDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back_rounded));

  @override
  Widget buildResults(BuildContext context) {
    if (query == '') return const SizedBox();

    // TODO: Implement language and searchIn parameters
    context.read<SearchCubit>().searchArticles(
          query: query,
          searchIn: 'title,description,content',
          language: 'en',
        );

    return BlocBuilder<SearchCubit, SearchState>(builder: (context, state) {
      return switch (state) {
        SearchInitial() =>
          const Center(child: CircularProgressIndicator.adaptive()),
        Searching() =>
          const Center(child: CircularProgressIndicator.adaptive()),
        SearchingSuccess() => state.articles.isEmpty
            ? const Center(
                child: Text('Could not find the article you are looking for'))
            : CardsScroll(articles: state.articles),
        SearchingError() => Center(child: Text('Error: ${state.message}')),
        _ => const Center(child: Text('Unkown Error')),
      };
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions with a search history
    return const SizedBox();
  }
}
