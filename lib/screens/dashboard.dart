import 'package:flutter/material.dart'
    show StatelessWidget, BuildContext, Widget, Scaffold, Column, Text;

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Column(children: [Text('Dashboard Screen')]));
  }
}
