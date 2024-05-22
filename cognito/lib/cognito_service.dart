import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CognitoService {
  CognitoService._();

  static final _userPool = CognitoUserPool(
    dotenv.env['USER_POOL_ID'] ?? '',
    dotenv.env['CLIENT_ID'] ?? '',
  );

  static Future<void> signUp(String email, String password) async {
    try {
      await _userPool.signUp(
        email,
        password,
      );
    } catch (e) {
      debugPrint('Failed to sign up: $e');
    }
  }

  static Future<void> confirmRegistration(
    String email,
    String confirmationCode,
  ) async {
    final cognitoUser = CognitoUser(email, _userPool);
    try {
      await cognitoUser.confirmRegistration(confirmationCode);
    } catch (e) {
      debugPrint('Failed to confirmation registration: $e');
    }
  }
}
