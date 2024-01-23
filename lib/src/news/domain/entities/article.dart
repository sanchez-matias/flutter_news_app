import 'package:equatable/equatable.dart';

class Article extends Equatable {
  final String? author;
  final String? content;
  final String? description;
  final String? publishedAt;
  final String? sourceName;
  final String? title;
  final String? url;
  final String? urlToImage;

  const Article({
    this.author,
    this.content,
    this.description,
    this.publishedAt,
    this.sourceName,
    this.title,
    this.url,
    this.urlToImage,
  });

  const Article.empty()
      : this(
          author: 'empty',
          content: 'empty',
          description: 'empty',
          publishedAt: 'empty',
          sourceName: 'empty',
          title: 'empty',
          url: 'empty',
          urlToImage: 'empty',
        );

  @override
  List<Object?> get props {
    return [
      author,
      content,
      description,
      publishedAt,
      sourceName,
      title,
      url,
      urlToImage,
    ];
  }
}
