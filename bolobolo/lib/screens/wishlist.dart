import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class Wishlist extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<Wishlist> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Text("My Wishlist"),
      ),
      body: new Container(
        color: Colors.purpleAccent,
        child: Column(
          children: [
            Text(
              'Wishlist',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Expanded(
              child: new ListView.builder(
                itemBuilder: (_, int index) => EachList(),
                itemCount: 151,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class EachList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new Container(
        decoration: BoxDecoration(
          color: Colors.amber,
          border: Border.all(width: 5.0, color: Colors.yellowAccent),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        margin: EdgeInsets.all(4),
        padding: EdgeInsets.all(8.0),
        child: new Row(
          children: [
            Container(
              child: CircleAvatar(
                radius: 30,
              ),
              padding: EdgeInsets.only(right: 50.0),
            ),
            Text('Item Name', style: TextStyle(fontSize: 20.0)),
          ],
        ),
      ),
    );
  }
}
