import 'package:flutter/material.dart';

class AnimalsScreen extends StatelessWidget {
  final Widget child;

  const AnimalsScreen({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: child),
    );
  }
}
