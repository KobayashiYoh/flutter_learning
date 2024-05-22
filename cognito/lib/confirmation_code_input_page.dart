import 'package:cognito/cognito_service.dart';
import 'package:flutter/material.dart';

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

  Future<void> _signUp() async {
    try {
      await CognitoService.confirmRegistration(
        widget.email,
        _confirmationCodeController.text,
      );
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
