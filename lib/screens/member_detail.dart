import 'package:flutter/material.dart'
    show StatelessWidget, BuildContext, Widget, Scaffold, Column, Text;

class MemberDetailScreen extends StatelessWidget {
  const MemberDetailScreen({super.key, required this.memberId});

  final int? memberId;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(children: [Text('Member Detail Screen')]),
    );
  }
}
