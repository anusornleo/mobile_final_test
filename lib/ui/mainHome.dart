import 'package:flutter/material.dart';

class MainHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Home",
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Container(
              child: new Center(
                child: new Text(
                  "Home",
                  style: TextStyle(fontSize: 30.0, color: Colors.grey),
                ),
              ),
            ),
            Container(
              child: new Center(
                child: new Text(
                  "Notify",
                  style: TextStyle(fontSize: 30.0, color: Colors.grey),
                ),
              ),
            ),
            Container(
              child: new Center(
                child: new Text(
                  "Map",
                  style: TextStyle(fontSize: 30.0, color: Colors.grey),
                ),
              ),
            ),
            Container(
              child: new Center(
                child: new Text(
                  "Profile",
                  style: TextStyle(fontSize: 30.0, color: Colors.grey),
                ),
              ),
            ),
            Container(
              child: new Center(
                child: new Text(
                  "Setup",
                  style: TextStyle(fontSize: 30.0, color: Colors.grey),
                ),
              ),
            ),
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
