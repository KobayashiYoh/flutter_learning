import 'package:flutter/material.dart';

@immutable
class Article {
  final String id;
  final String title;
  final String imageUrl;

  const Article({
    required this.id,
    required this.title,
    required this.imageUrl,
  });
}

extension ArticleExt on Article {
  bool get hasImageUrl => imageUrl.isNotEmpty;
}
