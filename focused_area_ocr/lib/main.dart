import 'dart:async';

import 'package:flutter/material.dart';
import 'package:focused_area_ocr_flutter/focused_area_ocr_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Focused Area OCR Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final StreamController<String> controller = StreamController<String>();
  final double _textViewHeight = 80.0;

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).viewPadding.top;
    final Offset focusedAreaCenter = Offset(
      0,
      (statusBarHeight + kToolbarHeight + _textViewHeight) / 2,
    );
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          FocusedAreaOCRView(
            onScanText: (text) {
              controller.add(text);
            },
            focusedAreaCenter: focusedAreaCenter,
          ),
          Column(
            children: [
              SizedBox(
                height: statusBarHeight + kToolbarHeight,
                child: AppBar(
                  title: const Text('Focused Area OCR Flutter'),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                width: double.infinity,
                height: _textViewHeight,
                color: Colors.black,
                child: StreamBuilder<String>(
                  stream: controller.stream,
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    return Text(
                      snapshot.data != null ? snapshot.data! : '',
                      style: const TextStyle(color: Colors.white),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
