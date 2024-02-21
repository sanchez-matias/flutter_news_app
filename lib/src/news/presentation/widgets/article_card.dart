import 'package:flutter/material.dart';
import 'package:flutter_news_app/src/news/domain/entities/article.dart';

class ArticleCard extends StatelessWidget {
  final Article article;

  const ArticleCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(article.title!),
        ),
      ),
    );
  }
}
