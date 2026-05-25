import 'package:flutter/material.dart'
    show StatelessWidget, BuildContext, Widget, Scaffold, Column, Text;

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Column(children: [Text('Auth Screen')]));
  }
}
