import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoriesListPage extends StatefulWidget {
  @override
  CategoriesPageState createState() => new CategoriesPageState();
}

class CategoriesPageState extends State<CategoriesListPage> {
  late List data;

  Future<String> getData() async {
    var response = await http.get(
        Uri.parse("https://northwind.vercel.app/api/categories"),
        headers: {"Accept": "application/json"});
    this.setState(() {
      data = json.decode(response.body);
    });
    print(data[1]["title"]);
    return "Success!";
  }

  @override
  void initState() {
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text("Mini Uygulama"), backgroundColor: Colors.blue),
      body: new ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            child: new Card(
              child: new Column(
                children: [
                  new Text(data[index]["name"]),
                  new Text(data[index]["description"])
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
