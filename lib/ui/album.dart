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
  List data;
  Future<String> makeRequest() async {
    var response = await http.get(Uri.encodeFull(url));
    setState(() {
      var extractdata = json.decode(response.body);
      data = extractdata["photos"];
    });
  }

  @override
  void initState() {
    this.makeRequest();
  }

  @override
  Widget build(BuildContext context) {
    print(data);
    return Scaffold(
      appBar: AppBar(title: Text("Album")),
      // body: ListView.builder(
      //   itemCount: data == null ? 0 : data.length,
      //   itemBuilder: (BuildContext context, i) {
      //     return new Card(
      //         child: Column(
      //       children: <Widget>[
      //         SizedBox(
      //           height: 180,
      //           child: Stack(
      //             children: <Widget>[
      //               Positioned.fill(child: Image.network(data[i]["thumbnail"]))
      //             ],
      //           ),
      //         )
      //       ],
      //     ));
      //   },
      // ),
    );
  }
}
