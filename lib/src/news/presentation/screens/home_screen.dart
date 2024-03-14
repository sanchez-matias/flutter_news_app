import 'package:flutter/material.dart';
import 'package:flutter_news_app/src/news/presentation/delegates/search_delegate.dart';
import 'package:flutter_news_app/src/news/presentation/views/views.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
          length: 3,
          initialIndex: 1,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                floating: true,
                snap: true,
                centerTitle: true,
                title: const Text('News'),
                actions: [
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.settings)),
                ],
                bottom: const TabBar(tabs: [
                  Tab(
                    //text: 'Categories',
                    child: Icon(Icons.category_rounded),
                  ),
                  Tab(
                    //text: 'Home',
                    child: Icon(Icons.home_rounded),
                  ),
                  Tab(
                    //text: 'Storage',
                    child: Icon(Icons.bookmark_rounded),
                  ),
                ]),
              ),
            ],
            body: const TabBarView(children: [
              CategoriesView(),
              HomeView(),
              StrorageView(),
            ]),
          )),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.search),
        onPressed: () {
          showSearch(
            context: context,
            delegate: SearchArticleDelegate(),
          );
        },
      ),
    );
  }
}
