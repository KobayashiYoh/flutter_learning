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

class HyperlinkText extends StatelessWidget {
  const HyperlinkText({super.key, required this.text});

  final String text;

  final TextStyle normalStyle = const TextStyle(color: Colors.black);
  final TextStyle hyperlinkStyle = const TextStyle(color: Colors.blue);

  List<Match> allMatchList() {
    final List<Match> allMatches = [];

    final urlMatches = Patterns.url.allMatches(text);
    final mentionMatches = Patterns.mention.allMatches(text);
    final hashtagMatches = Patterns.hashtagPattern.allMatches(text);

    allMatches.addAll(urlMatches);
    allMatches.addAll(mentionMatches);
    allMatches.addAll(hashtagMatches);
    allMatches.sort((a, b) => a.start.compareTo(b.start));

    return allMatches;
  }

  List<TextSpan> textSpan(List<Match> allMatches) {
    final parts = <TextSpan>[];
    int currentPosition = 0;

    for (var match in allMatches) {
      if (currentPosition < match.start) {
        final textPart = text.substring(currentPosition, match.start);
        parts.add(TextSpan(text: textPart, style: normalStyle));
      }

      final matchedText = text.substring(match.start, match.end);
      if (Patterns.url.hasMatch(matchedText)) {
        final url = matchedText.replaceAll(' ', '');
        parts.add(
          TextSpan(
            text: matchedText,
            style: hyperlinkStyle,
            recognizer: TapGestureRecognizer()..onTap = () => onTapUrl(url),
          ),
        );
      } else if (Patterns.mention.hasMatch(matchedText)) {
        parts.add(
          TextSpan(
            text: matchedText,
            style: hyperlinkStyle,
            recognizer: TapGestureRecognizer()..onTap = onTapMention,
          ),
        );
      } else if (Patterns.hashtagPattern.hasMatch(matchedText)) {
        parts.add(
          TextSpan(
            text: matchedText,
            style: hyperlinkStyle,
            recognizer: TapGestureRecognizer()..onTap = onTapHashtag,
          ),
        );
      }

      currentPosition = match.end;
    }
    if (currentPosition < text.length) {
      final remainingText = text.substring(currentPosition);
      parts.add(TextSpan(text: remainingText, style: normalStyle));
    }
    return parts;
  }

  void onTapMention() {
    debugPrint('On tap mention');
  }

  void onTapUrl(String url) {
    debugPrint('On tap Url: $url');
  }

  void onTapHashtag() {
    debugPrint('On tap hashtag');
  }

  @override
  Widget build(BuildContext context) {
    final List<Match> allMatches = allMatchList();
    final parts = textSpan(allMatches);
    if (allMatches.isNotEmpty) {
      return RichText(
        text: TextSpan(children: parts),
      );
    } else {
      return RichText(
        text: TextSpan(text: text),
      );
    }
  }
}
