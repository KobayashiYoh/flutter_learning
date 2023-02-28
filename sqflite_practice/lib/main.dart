import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await openDatabase(
    join(await getDatabasesPath(), 'timer_database.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE timer(id INTEGER PRIMARY KEY, hour INTEGER, minute INTEGER, second INTEGER)',
      );
    },
    version: 1,
  );

  runApp(MyApp(database: database));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.database});
  final Database database;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(database: database),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.database});
  final Database database;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Timer> _timerList = [];

  // Define a function that inserts dogs into the database
  Future<void> insertTimer(Timer timer) async {
    // Get a reference to the database.
    final db = widget.database;

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'timer',
      timer.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // A method that retrieves all the dogs from the dogs table.
  Future<List<Timer>> timer() async {
    // Get a reference to the database.
    final db = widget.database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('timer');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Timer(
        id: maps[i]['id'],
        hour: maps[i]['hour'],
        minute: maps[i]['minute'],
        second: maps[i]['second'],
      );
    });
  }

  Future<void> updateTimer(Timer timer) async {
    // Get a reference to the database.
    final db = widget.database;

    // Update the given Dog.
    await db.update(
      'timer',
      timer.toMap(),
      // Ensure that the Dog has a matching id.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [timer.id],
    );
  }

  Future<void> deleteDog(int id) async {
    // Get a reference to the database.
    final db = widget.database;

    // Remove the Dog from the database.
    await db.delete(
      'dogs',
      // Use a `where` clause to delete a specific dog.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

  void _onPressedAddButton() async {
    final DateTime now = DateTime.now();
    insertTimer(
      Timer(
        id: now.microsecondsSinceEpoch,
        hour: now.hour,
        minute: now.minute,
        second: now.second,
      ),
    );
    _timerList = await timer();
    setState(() {});
  }

  @override
  void didChangeDependencies() async {
    _timerList = await timer();
    setState(() {});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text(''),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: _timerList.length,
          itemBuilder: (BuildContext context, int index) => ListTile(
            title: Text(
                '${_timerList[index].hour}時間${_timerList[index].minute}分${_timerList[index].second}秒'),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onPressedAddButton,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Timer {
  final int id;
  final int hour;
  final int minute;
  final int second;

  const Timer({
    required this.id,
    required this.hour,
    required this.minute,
    required this.second,
  });

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'hour': hour,
      'minute': minute,
      'second': second,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Dog{id: $id, hour: $hour, minute: $minute, second: $second}';
  }
}
