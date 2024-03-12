import 'package:flutter/material.dart';

import '../../domain/entities/article.dart';
import 'article_card.dart';

class CardsScroll extends StatelessWidget {
  final List<Article> articles;
  const CardsScroll({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) => ArticleCard(
        article: articles[index],
      ),
    );
  }
}
