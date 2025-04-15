import 'package:flutter/material.dart';
import 'package:flutter_shared_preferences_demo/services/local_storage_services.dart';

void main() async {
  await LocalStorageServices.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
