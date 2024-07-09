import 'package:attendance/core/data_source/firebase/firebase_services.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(
          onPressed: () async {
             await FirebaseServices.deleteDoc(
              collection: 'test',
              id: '5454sf5',
            );
          },
          icon: const Icon(Icons.add),
        ),
      ),
    );
  }
}
