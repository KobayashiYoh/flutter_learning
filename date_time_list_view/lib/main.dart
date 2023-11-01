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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<DateTime> _dateTimes = [];

  final List<DateTime> _initialFetchedDateTimes = [
    DateTime(2023, 1, 1),
    DateTime(2023, 1, 1),
    DateTime(2023, 1, 1),
    DateTime(2023, 1, 1),
    DateTime(2023, 1, 2),
    DateTime(2023, 1, 2),
    DateTime(2023, 1, 2),
    DateTime(2023, 1, 9),
    DateTime(2023, 1, 9),
    DateTime(2023, 1, 9),
    DateTime(2023, 1, 9),
  ];

  @override
  void initState() {
    super.initState();
    _dateTimes = _initialFetchedDateTimes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _dateTimes.length,
        itemBuilder: (context, index) {
          final shouldShowTitle = index == 0 ||
              (index > 0 && _dateTimes[index] != _dateTimes[index - 1]);
          if (shouldShowTitle) {
            // 日付が変わった場合、タイトルを表示
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 64.0),
                Text(
                  'Title: ${_dateTimes[index].year}/${_dateTimes[index].month}/${_dateTimes[index].day}',
                ),
                ListItem(dateTime: _dateTimes[index], index: index),
              ],
            );
          } else {
            // 日付が同じ場合、タイトルは表示せずアイテムのみ表示
            return ListItem(dateTime: _dateTimes[index], index: index);
          }
        },
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  const ListItem({
    Key? key,
    required this.dateTime,
    required this.index,
  }) : super(key: key);
  final DateTime dateTime;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      color: Colors.grey[200],
      child: Text(
        '$index. ${dateTime.year}/${dateTime.month}/${dateTime.day}',
        style: const TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
