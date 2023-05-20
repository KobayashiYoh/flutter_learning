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
      home: const MyHomePage(),
    );
  }
}

enum Sex {
  man,
  woman,
  none,
}

extension SexExtensions on Sex {
  get text {
    switch (this) {
      case Sex.man:
        return '男性';
      case Sex.woman:
        return '女性';
      case Sex.none:
        return '無回答';
    }
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DropdownButton<Sex>(
          items: [
            for (var sex in Sex.values)
              DropdownMenuItem(
                value: sex,
                child: Text(sex.text),
              ),
          ],
          onChanged: (Sex? value) {},
        ),
      ),
    );
  }
}
