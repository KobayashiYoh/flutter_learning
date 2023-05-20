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

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Sex dropdownValue = Sex.none;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: DropdownButton<Sex>(
            value: dropdownValue,
            onChanged: (Sex? value) {
              setState(() {
                dropdownValue = value!;
              });
            },
            items: [
              for (var sex in Sex.values)
                DropdownMenuItem(
                  value: sex,
                  child: Text(sex.text),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
