import 'package:final_project_test/model/modelUser.dart';
import 'package:final_project_test/ui/login.dart';
import 'package:final_project_test/ui/profile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  List<Todo> items = new List();
  Todo alldata;
  Home(this.alldata, this.items);
  @override
  State<StatefulWidget> createState() {
    return HomeState(alldata, items);
  }
}

class HomeState extends State {
  List<Todo> items = new List();
  Todo alldata;
  HomeState(this.alldata, this.items);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("HOME")),
        body: Container(
          margin: EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              Text("data"),
              Text("data"),
              RaisedButton(
                child: Text("Profile"),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Profile(alldata)));
                },
              ),
              RaisedButton(
                child: Text("My Friends"),
                onPressed: () {},
              ),
              RaisedButton(
                child: Text("Sign out"),
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.remove('user');
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginForm(items)));
                },
              ),
            ],
          ),
        ));
  }
}
