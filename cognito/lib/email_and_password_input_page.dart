import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:cognito/confirmation_code_input_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EmailAndPasswordInputPage extends StatefulWidget {
  const EmailAndPasswordInputPage({super.key});

  @override
  State<EmailAndPasswordInputPage> createState() =>
      _EmailAndPasswordInputPageState();
}

class _EmailAndPasswordInputPageState extends State<EmailAndPasswordInputPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _userPool = CognitoUserPool(
    dotenv.env['USER_POOL_ID'] ?? '',
    dotenv.env['CLIENT_ID'] ?? '',
  );

  Future<void> _signUp() async {
    try {
      await _userPool.signUp(
        _emailController.text,
        _passwordController.text,
      );
    } catch (e) {
      debugPrint('Failed to sign up: $e');
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
              onPressed: _signUp,
              child: const Text('確認コードを送信'),
            ),
          ],
        ),
      ),
    );
  }
}
