import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:oauth/model/user.dart';

class GitHubRepository {
  static Future<String> createAccessToken(String code) async {
    final String clientId = dotenv.get('CLIENT_ID');
    final String clientSecret = dotenv.get('CLIENT_SECRET');
    final response = await http.post(
      Uri.parse('https://github.com/login/oauth/access_token'),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode(
        <String, String>{
          'client_id': clientId,
          'client_secret': clientSecret,
          'code': code,
        },
      ),
    );
    if (response.statusCode == 200) {
      final String accessTokenParameter = response.body.split('&').first;
      final String accessToken = accessTokenParameter.split('=').last;
      return accessToken;
    } else {
      throw Exception(
        'Request failed with status: ${response.statusCode}',
      );
    }
  }

  static Future<User> fetchUser(String accessToken) async {
    final response = await http.get(
      Uri.parse('https://api.github.com/user'),
      headers: <String, String>{
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception(
        'Request failed with status: ${response.statusCode}',
      );
    }
  }
}
