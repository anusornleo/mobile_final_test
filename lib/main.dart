import 'package:final_project_test/ui/json_data_ui.dart';
import 'package:final_project_test/ui/login.dart';
import 'package:final_project_test/ui/wait.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Wait(),
    );
  }
}
