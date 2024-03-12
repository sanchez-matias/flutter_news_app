import 'package:flutter/material.dart';
import 'package:flutter_news_app/src/news/domain/entities/article.dart';
import 'package:flutter_news_app/src/news/presentation/screens/article_screen.dart';

class ArticleCard extends StatelessWidget {
  final Article article;

  const ArticleCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      margin: const EdgeInsets.all(10),
      clipBehavior: Clip.antiAlias,
      elevation: 3,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ArticleScreen(article: article),
              ));
        },
        child: Column(
          children: [

            FadeInImage(
              fit: BoxFit.cover,
              placeholderFit: BoxFit.fitHeight,
              height: 250,
              width: double.infinity,
              placeholder: const AssetImage('assets/articles/loading-circle.gif'),
              image: NetworkImage(article.urlToImage!),
              imageErrorBuilder: (context, error, stackTrace) => Image.asset('assets/articles/no-image.jpg'),
            ),

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
