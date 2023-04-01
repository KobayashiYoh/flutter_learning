import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:oauth/model/access_token.dart';
import 'package:oauth/model/user.dart';
import 'package:oauth/repository/qiita_repository.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    final String clientId = dotenv.get('CLIENT_ID');
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) async {
            print(url);
            final bool hasCode =
                url.contains('https://qiita.com/settings/applications?code=');
            if (hasCode) {
              String code =
                  url.split('https://qiita.com/settings/applications?code=')[1];
              final AccessToken accessToken =
                  await QiitaRepository.createAccessToken(code);
              final User user =
                  await QiitaRepository.fetchUser(accessToken.token);
              print(user.id);
            }
          },
        ),
      )
      ..loadRequest(
        Uri.parse(
          'https://qiita.com/api/v2/oauth/authorize?client_id=$clientId&scope=read_qiita',
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(controller: _controller),
    );
  }
}
