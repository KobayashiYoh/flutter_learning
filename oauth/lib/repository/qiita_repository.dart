import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:oauth/model/access_token.dart';
import 'package:oauth/model/user.dart';

class QiitaRepository {
  static const String baseUrl = 'https://qiita.com';

  static Future<AccessToken> createAccessToken(String code) async {
    final String clientId = dotenv.get('CLIENT_ID');
    final String clientSecret = dotenv.get('CLIENT_SECRET');
    final response = await http.post(
      Uri.parse('$baseUrl/api/v2/access_tokens'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        <String, String>{
          'client_id': clientId,
          'client_secret': clientSecret,
          'code': code,
        },
      ),
    );
    if (response.statusCode == 201) {
      return AccessToken.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
        'Access token request failed with status: ${response.statusCode}',
      );
    }
  }

  static Future<User> fetchUser(String accessToken) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/v2/authenticated_user'),
      headers: <String, String>{
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );
    print(response.request);
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
        'User request failed with status: ${response.statusCode}',
      );
    }
  }
}
