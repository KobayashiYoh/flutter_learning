import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  final String text = '''
    こんにちは @userさん！
    新しい https://www.example.comへようこそ！
    記念すべき #初投稿 ですね！
  ''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: HyperlinkText(text: text),
        ),
      ),
    );
  }
}

class Patterns {
  Patterns._();

  static final RegExp url = RegExp(r" https?://[\w!?/+\-_~;.,*&@#$%()'[\]]+");
  static final RegExp mention = RegExp(r' @(\w+)');
  static final RegExp hashtagPattern = RegExp(r'#[0-9a-zA-Zぁ-んァ-ヶｱ-ﾝﾞﾟ一-龠]+');
}

class Styles {
  Styles._();

  static const TextStyle normal = TextStyle(color: Colors.black);
  static const TextStyle hyperlink = TextStyle(color: Colors.blue);
}

class HyperlinkText extends StatelessWidget {
  const HyperlinkText({super.key, required this.text});

  final String text;

  List<Match> matchList() {
    final List<Match> matches = [];

    final urlMatches = Patterns.url.allMatches(text);
    final mentionMatches = Patterns.mention.allMatches(text);
    final hashtagMatches = Patterns.hashtagPattern.allMatches(text);

    matches.addAll(urlMatches);
    matches.addAll(mentionMatches);
    matches.addAll(hashtagMatches);
    matches.sort((a, b) => a.start.compareTo(b.start));

    return matches;
  }

  List<TextSpan> textSpanList(List<Match> allMatches) {
    final textSpans = <TextSpan>[];
    int currentPosition = 0;

    for (var match in allMatches) {
      if (currentPosition < match.start) {
        final textPart = text.substring(currentPosition, match.start);
        textSpans.add(
          TextSpan(text: textPart, style: Styles.normal),
        );
      }

      final matchedText = text.substring(match.start, match.end);
      if (Patterns.url.hasMatch(matchedText)) {
        final url = matchedText.replaceAll(' ', '');
        textSpans.add(
          TextSpan(
            text: matchedText,
            style: Styles.hyperlink,
            recognizer: TapGestureRecognizer()..onTap = () => onTapUrl(url),
          ),
        );
      } else if (Patterns.mention.hasMatch(matchedText)) {
        final mention = matchedText.replaceAll(' ', '');
        textSpans.add(
          TextSpan(
            text: matchedText,
            style: Styles.hyperlink,
            recognizer: TapGestureRecognizer()
              ..onTap = () => onTapMention(mention),
          ),
        );
      } else if (Patterns.hashtagPattern.hasMatch(matchedText)) {
        textSpans.add(
          TextSpan(
            text: matchedText,
            style: Styles.hyperlink,
            recognizer: TapGestureRecognizer()
              ..onTap = () => onTapHashtag(matchedText),
          ),
        );
      }

      currentPosition = match.end;
    }
    if (currentPosition < text.length) {
      final remainingText = text.substring(currentPosition);
      textSpans.add(
        TextSpan(text: remainingText, style: Styles.normal),
      );
    }
    return textSpans;
  }

  void onTapMention(String mention) {
    debugPrint('On tap mention: $mention');
  }

  void onTapUrl(String url) {
    debugPrint('On tap url: $url');
  }

  void onTapHashtag(String hashtag) {
    debugPrint('On tap hashtag: $hashtag');
  }

  @override
  Widget build(BuildContext context) {
    final allMatches = matchList();
    final textSpans = textSpanList(allMatches);
    return RichText(
      text: allMatches.isEmpty
          ? TextSpan(text: text)
          : TextSpan(children: textSpans),
    );
  }
}
