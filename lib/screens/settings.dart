import 'package:flutter/material.dart'
    show StatelessWidget, BuildContext, Widget, Scaffold, Column, Text;

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Column(children: [Text('Settings Screen')]));
  }
}
