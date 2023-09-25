import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginContainer extends StatelessWidget {
  const LoginContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            Text('Login')
          ],
        ),
      )
    );
  }
}
