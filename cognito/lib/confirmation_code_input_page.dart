import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ConfirmationCodeInputPage extends StatefulWidget {
  const ConfirmationCodeInputPage({
    super.key,
    required this.email,
  });

  final String email;

  @override
  State<ConfirmationCodeInputPage> createState() =>
      _ConfirmationCodeInputPageState();
}

class _ConfirmationCodeInputPageState extends State<ConfirmationCodeInputPage> {
  final _confirmationCodeController = TextEditingController();
  final _userPool = CognitoUserPool(
    dotenv.env['USER_POOL_ID'] ?? '',
    dotenv.env['CLIENT_ID'] ?? '',
  );

  Future<void> _signUp() async {
    final cognitoUser = CognitoUser(widget.email, _userPool);
    try {
      await cognitoUser.confirmRegistration(_confirmationCodeController.text);
    } catch (e) {
      debugPrint('Failed to confirmation registration: $e');
    }
  }

  @override
  void dispose() {
    _confirmationCodeController.dispose();
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
              controller: _confirmationCodeController,
              decoration: const InputDecoration(
                label: Text('確認コード（6桁）'),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _signUp,
              child: const Text('アカウントを登録'),
            ),
          ],
        ),
      ),
    );
  }
}
