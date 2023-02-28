import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

void main() async {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('グラグラの実アプリ'),
        ),
        body: Builder(
          builder: (BuildContext context) {
            return Container(
              alignment: Alignment.bottomCenter,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://devil-fruit.sakura.ne.jp/wp1/wp-content/uploads/2020/01/guragura-no-mi.png',
                  ),
                ),
              ),
              child: Container(
                margin: const EdgeInsets.all(32.0),
                width: double.infinity,
                height: 48.0,
                child: ElevatedButton(
                  child: const Text(
                    'グラグラの能力を発動',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Vibration.vibrate(
                      pattern: [500, 2000],
                      intensities: [0, 255],
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
