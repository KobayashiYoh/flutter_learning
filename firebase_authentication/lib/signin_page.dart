import 'package:flutter/material.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign in'),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: const InputDecoration(hintText: 'メールアドレス'),
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'パスワード'),
              ),
              const SizedBox(height: 40.0),
              ElevatedButton(
                onPressed: () {},
                child: const Text('ログインする'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
