import 'package:flutter/material.dart';
import 'package:flutter_news_app/src/news/domain/entities/article.dart';
import 'package:flutter_news_app/src/news/presentation/screens/article_screen.dart';

class ArticleCard extends StatelessWidget {
  final Article article;

  const ArticleCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArticleScreen(article: article),
            ));
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 3,
        child: Column(
          children: [
            Image.network(article.urlToImage ??
                'https://t4.ftcdn.net/jpg/02/51/13/11/360_F_251131195_YKAgbS5YEeDSUmNg69MtEOV3OYxrM2ml.jpg'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                article.title!,
                style: textTheme.titleLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
