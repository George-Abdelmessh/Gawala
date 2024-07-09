import 'package:attendance/core/data_source/firebase_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(
          icon: Icon(Icons.add),
          onPressed: () async {
          },
        ),
      ),
    );
  }
}
