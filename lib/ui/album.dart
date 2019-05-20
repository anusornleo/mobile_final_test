import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Album extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AlbumState();
  }
}

class AlbumState extends State {
  String url = 'https://jsonplaceholder.typicode.com/albums/1/photos';
  var data;
  Future<String> makeRequest() async {
    var response = await http.get(Uri.encodeFull(url));
    setState(() {
      data = json.decode(response.body).cast<Map<String, dynamic>>();
    });
  }

  @override
  void initState() {
    this.makeRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Album")),
      body: data == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, i) {
                return new Card(
                    child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 180,
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                              child: Image.network(data[i]["thumbnailUrl"]))
                        ],
                      ),
                    )
                  ],
                ));
              },
            ),
    );
  }
}
