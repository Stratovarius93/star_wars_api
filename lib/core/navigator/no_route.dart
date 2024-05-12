import 'package:flutter/material.dart';

class NoRoute extends StatelessWidget {
  const NoRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('No route defined for this page'),
      ),
    );
  }
}
