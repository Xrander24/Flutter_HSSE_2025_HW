import 'package:flutter/material.dart';
import './cat_swipe_screen.dart';

void main() {
  runApp(CatApp());
}

class CatApp extends StatelessWidget {
  const CatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CatSwipeScreen(),
    );
  }
}
