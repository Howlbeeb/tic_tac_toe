import 'package:flutter/material.dart';

import 'homepage.dart';

void main() {
  runApp(MyApp());
}
final ThemeData theme = ThemeData();
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme.copyWith(
    colorScheme: theme.colorScheme.copyWith(
      primary: Colors.black26,
      secondary: Colors.black,
    ),
    ),
      home: Homepage(),
    );
  }
}
