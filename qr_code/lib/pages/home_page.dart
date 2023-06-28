import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: QrImage(
            data: 'https://pub.dev/packages/qr_flutter',
            embeddedImage: const AssetImage(
              'assets/images/flutter_logo.png',
            ),
          ),
        ),
      ),
    );
  }
}
