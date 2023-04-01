import 'package:flutter/material.dart';
import 'package:oauth/model/user.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                user.profileImageUrl,
                width: 120.0,
              ),
              Text(
                user.id,
                style: const TextStyle(fontSize: 24.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
