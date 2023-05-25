import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    final UserCredential result =
        await FirebaseAuth.instance.signInWithCredential(credential);
    return result;
  }

  Future<UserCredential> signInWithApple() async {
    print('AppSignInを実行');

    final rawNonce = generateNonce();

    // 現在サインインしているAppleアカウントのクレデンシャルを要求する。
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    print(appleCredential);
    // Apple から返されたクレデンシャルから `OAuthCredential` を作成します。
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );
    print(appleCredential);
    // Firebaseでユーザーにサインインします。もし、先ほど生成したnonceが
    // が `appleCredential.identityToken` の nonce と一致しない場合、サインインに失敗します。
    return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
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
              // yokobayashi2001@gmail.com
              SignInButton(
                Buttons.Google,
                onPressed: signInWithGoogle,
              ),
              SignInWithAppleButton(
                onPressed: signInWithApple,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
