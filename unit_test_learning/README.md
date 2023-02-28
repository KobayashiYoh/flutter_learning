## 概要
1日でも早くテストコードを書けるようになっておきたいと考え、Flutterにおけるテストコード（今回はユニットテスト）の書き方を学びました。

## 学んだ内容
* ユニットテストの文法
  * test
  * except
  * group

## テストを走らせるコマンド
```
flutter test test
```

## ソースコード
### article.dart
```dart
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
```

### article_test.dart
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:unit_test_learning/model/article.dart';

void main() {
  group('Article model test', () {
    test('Article model test 1', () {
      const article = Article(
        id: '123',
        title: 'HRT(謙虚/尊敬/信頼)を大切にしよう',
        imageUrl: '',
      );

      expect(article.id, '123');
      expect(article.title, 'HRT(謙虚/尊敬/信頼)を大切にしよう');
      expect(article.imageUrl, '');
      expect(article.hasImageUrl, false);
    });

    test('Article model test 2', () {
      const article = Article(
        id: '456',
        title: '怠惰は褒め言葉？',
        imageUrl: '',
      );

      expect(article.id, '456');
      expect(article.title, '怠惰は褒め言葉？');
      expect(article.imageUrl, '');
      expect(article.hasImageUrl, false);
    });

    test('Article model test 3', () {
      const article = Article(
        id: '789',
        title: '近所にできたラーメン屋のチャーハンがうまい件について',
        imageUrl: 'https://image3.jpg',
      );

      expect(article.id, '789');
      expect(article.title, '近所にできたラーメン屋のチャーハンがうまい件について');
      expect(article.imageUrl, 'https://image3.jpg');
      expect(article.hasImageUrl, true);
    });
  });
}

```

## 参考
https://blog.pentagon.tokyo/2387/
