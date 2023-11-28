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
      home: const MyHomePage(),
    );
  }
}

class CameraPreviewPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Rect deviceRect = Offset.zero & size;
    final RRect centerRRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: 200,
        height: 80.0,
      ),
      const Radius.circular(8.0),
    );
    final paint = Paint()..color = const Color(0xCC000000);
    canvas.drawPath(
      Path.combine(
        PathOperation.difference,
        Path()..addRect(deviceRect),
        Path()..addRRect(centerRRect),
      ),
      paint,
    );
  }

  // Since this Sky painter has no fields, it always paints
  // the same thing and semantics information is the same.
  // Therefore we return false here. If we had fields (set
  // from the constructor) then we would return true if any
  // of them differed from the same fields on the oldDelegate.
  @override
  bool shouldRepaint(CameraPreviewPainter oldDelegate) => false;
  @override
  bool shouldRebuildSemantics(CameraPreviewPainter oldDelegate) => false;
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
                'https://cdn.pixabay.com/photo/2019/06/25/21/53/forest-4299156_1280.jpg'),
          ),
        ),
        child: CustomPaint(
          painter: CameraPreviewPainter(),
        ),
      ),
    );
  }
}
