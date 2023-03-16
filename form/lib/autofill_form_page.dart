import 'package:flutter/material.dart';

class AutofillFormPage extends StatelessWidget {
  const AutofillFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: AutofillGroup(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'ユーザーID'),
                autofillHints: const [AutofillHints.username],
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'パスワード'),
                autofillHints: const [AutofillHints.password],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
