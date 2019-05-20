import 'package:final_project_test/model/modelUser.dart';
import 'package:final_project_test/ui/Home.dart';
import 'package:final_project_test/ui/album.dart';
import 'package:final_project_test/ui/json_data_ui.dart';
import 'package:final_project_test/ui/profile.dart';
import 'package:flutter/material.dart';

class MainHome extends StatelessWidget {
  List<Todo> items = new List();
  Todo dataUser;
  MainHome(this.dataUser, this.items);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        // appBar: AppBar(
        //   centerTitle: true,
        //   title: Text(
        //     "Home",
        //   ),
        // ),
        body: TabBarView(
          children: <Widget>[
            // Container(
            //   child: new Center(
            //     child: new Text(
            //       "Home",
            //       style: TextStyle(fontSize: 30.0, color: Colors.grey),
            //     ),
            //   ),
            // ),
            Home(dataUser, items),
            Friend(),
            Profile(dataUser),
            Album(),
          ],
        ),
        bottomNavigationBar: new Material(
          color: Colors.blue,
          child: new TabBar(
            tabs: <Tab>[
              new Tab(
                icon: new Icon(Icons.view_quilt),
              ),
              new Tab(
                icon: new Icon(Icons.notifications),
              ),
              new Tab(
                icon: new Icon(Icons.explore),
              ),
              new Tab(
                icon: new Icon(Icons.person),
              ),
              new Tab(
                icon: new Icon(Icons.settings),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
