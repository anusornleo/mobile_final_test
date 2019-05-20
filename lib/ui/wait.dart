import 'package:final_project_test/model/modelUser.dart';
import 'package:final_project_test/ui/login.dart';
import 'package:final_project_test/ui/mainHome.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Wait extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return WaitState();
  }
}

class WaitState extends State {
  List<Todo> items = new List();
  final prefs = SharedPreferences.getInstance();

  TodoDatabase db = TodoDatabase();
  @override
  Future initState() {
    super.initState();
    db.getAllTask().then((todos) {
      // restart read data when it changed
      setState(() {
        print(todos.length);
        todos.forEach((note) {
          items.add(Todo.fromMap(note));
          print(items.length);
          // print(items[0].toMap());
        });
        getLogin();
      });
    });
  }

  Future<String> getLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final stateLogin = prefs.get('user') ?? 0;
    print(stateLogin);
    if (stateLogin != 0) {
      print("Alrady login");
      var dataUser =
          items.singleWhere((i) => i.id == stateLogin, orElse: () => null);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => MainHome(dataUser, items)));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginForm(items)));
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
