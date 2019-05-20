import 'package:final_project_test/model/modelUser.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  Todo dataUser;
  Profile(this.dataUser);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProfileState(dataUser);
  }
}

class ProfileState extends State {
  Todo dataUser;
  ProfileState(this.dataUser);
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
            Text(dataUser.id.toString()),
            Text(dataUser.username),
            Text("data")
          ],
        ),
      ),
    );
  }
}
