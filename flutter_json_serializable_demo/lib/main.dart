
import 'package:flutter/material.dart';
import 'package:flutter_json_serializable_demo/model/user.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
   MainApp({super.key});


  

  @override
  Widget build(BuildContext context) {

  final json = {
    "name": "Alice",
    "age": 30,
    "email":"alice@example.com",
    "role":"admin",
    "address":{"street":"123 main st", "city": "Metropolis"},
    "tags":["flutter", "dart"],
    "created_at":1680000000000

  };

  final user = User.fromJson(json);

    return  MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('${user.name}!'+ '${user.createdAt}' + '${user.role}'),
        ),
      ),
    );
  }
}
