import 'package:flutter/material.dart';
import '../../domain/entities/cat_entity.dart';

class CatDetailsScreen extends StatelessWidget {
  final Cat cat;

  const CatDetailsScreen({super.key, required this.cat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: Center(
          child: Text(cat.breed, style: TextStyle(color: Colors.white70)),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 6, // 40% экрана
            child: Image.network(cat.imageUrl, fit: BoxFit.cover),
          ),
          Expanded(
            flex: 4, // 60% экрана
            child: Padding(
              padding: EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Text(
                  cat.description,
                  style: TextStyle(fontSize: 20, color: Colors.white70),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
