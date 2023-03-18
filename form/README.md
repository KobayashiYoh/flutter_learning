# 自動入力フォーム
Flutterでフォームの自動入力ができるサンプルコードです。

## 練習用コード（自動入力できるように書き換えてみましょう）
```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AutofillFormPage(),
    );
  }
}

class AutofillFormPage extends StatelessWidget {
  const AutofillFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'ユーザーID'),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'パスワード'),
            ),
          ],
        ),
      ),
    );
  }
}
```

## 解答
https://github.com/KobayashiYoh/flutter_learning/blob/main/form/lib/main.dart
