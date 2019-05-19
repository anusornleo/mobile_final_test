import 'package:final_project_test/model/modelUser.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  Todo alldata;
  Profile(this.alldata);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProfileState(alldata);
  }
}

class ProfileState extends State {
  Todo alldata;
  ProfileState(this.alldata);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Container(
        margin: EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Text(alldata.id.toString()),
            Text(alldata.username),
            Text("data")
          ],
        ),
      ),
    );
  }
}
