import 'package:flutter/material.dart';
import 'package:flutter_dio_demo/config/environment.dart';

void main() {
  const env = String.fromEnvironment('ENV', defaultValue: 'dev');
  switch (env) {
    case 'staging':
      EnvironmentConfig.current = AppEnvironment.staging;
      break;
    case 'prod':
      EnvironmentConfig.current = AppEnvironment.prod;
      break;
    default:
      EnvironmentConfig.current = AppEnvironment.dev;
  }

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(body: Center(child: Text('Hello World!'))),
    );
  }
}
