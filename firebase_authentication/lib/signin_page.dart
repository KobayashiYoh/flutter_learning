import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  String _inputEmailAddress = '';
  String _inputPassword = '';
  String _resultMessage = '';

  void _onChangedEmailAddress(String value) {
    setState(() {
      _inputEmailAddress = value;
    });
  }

  void _onChangedPassword(String value) {
    setState(() {
      _inputPassword = value;
    });
  }

  void _onPressedSigninButton() async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final UserCredential result = await auth.signInWithEmailAndPassword(
        email: _inputEmailAddress,
        password: _inputPassword,
      );
      final User user = result.user!;
      setState(() {
        _resultMessage = 'ログイン完了!\nようこそ、${user.email}';
      });
    } catch (e) {
      setState(() {
        _resultMessage = 'ログイン失敗';
      });
      throw Exception(e);
    }
  }

  void _onPressedSignupButton() async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final UserCredential result = await auth.createUserWithEmailAndPassword(
        email: _inputEmailAddress,
        password: _inputPassword,
      );
      final User user = result.user!;
      setState(() {
        _resultMessage = '登録完了!\nようこそ、${user.email}';
      });
    } catch (e) {
      setState(() {
        _resultMessage = '登録失敗';
      });
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Authentication'),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_resultMessage),
              TextFormField(
                decoration: const InputDecoration(hintText: 'メールアドレス'),
                onChanged: _onChangedEmailAddress,
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'パスワード'),
                obscureText: true,
                onChanged: _onChangedPassword,
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _onPressedSigninButton,
                      child: const Text('ログイン'),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _onPressedSignupButton,
                      child: const Text('新規登録'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
