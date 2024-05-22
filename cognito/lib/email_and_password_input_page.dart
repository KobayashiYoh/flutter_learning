import 'package:cognito/cognito_service.dart';
import 'package:cognito/confirmation_code_input_page.dart';
import 'package:flutter/material.dart';

class EmailAndPasswordInputPage extends StatefulWidget {
  const EmailAndPasswordInputPage({super.key});

  @override
  State<EmailAndPasswordInputPage> createState() =>
      _EmailAndPasswordInputPageState();
}

class _EmailAndPasswordInputPageState extends State<EmailAndPasswordInputPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _onPressedSendConfirmationCode() async {
    try {
      await CognitoService.signUp(
        _emailController.text,
        _passwordController.text,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
    if (!mounted) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ConfirmationCodeInputPage(
          email: _emailController.text,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                label: Text('メールアドレス'),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                label: Text('パスワード'),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _onPressedSendConfirmationCode,
              child: const Text('確認コードを送信'),
            ),
          ],
        ),
      ),
    );
  }
}
