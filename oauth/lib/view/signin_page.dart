import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:oauth/model/user.dart';
import 'package:oauth/repository/git_hub_repository.dart';
import 'package:oauth/view/user_page.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  late WebViewController _controller;
  late User _user;

  Future<void> _signin(String url) async {
    String code = url
        .split('${GitHubRepository.baseUrl}/settings/applications/new?code=')
        .last;
    final String accessToken = await GitHubRepository.createAccessToken(code);
    _user = await GitHubRepository.fetchUser(accessToken);
  }

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
            final bool hasCode = url.contains(
                '${GitHubRepository.baseUrl}/settings/applications/new?code=');
            if (hasCode) {
              await _signin(url);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserPage(user: _user)),
              );
            }
          },
        ),
      )
      ..loadRequest(
        Uri.parse(
          '${GitHubRepository.baseUrl}/login/oauth/authorize?client_id=$clientId',
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
