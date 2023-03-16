import 'package:flutter/material.dart';
import 'package:form/autofill_form_page.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AutofillFormPage(),
                    ),
                  );
                },
                child: const Text('Autofill Form Page'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
