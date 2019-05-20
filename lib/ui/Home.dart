import 'package:final_project_test/model/modelUser.dart';
import 'package:final_project_test/ui/login.dart';
import 'package:final_project_test/ui/profile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  Todo alldata;
  Home(this.alldata);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeState(alldata);
  }
}

class HomeState extends State {
  Todo alldata;
  HomeState(this.alldata);
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginForm()));
                },
              ),
            ],
          ),
        ));
  }
}
