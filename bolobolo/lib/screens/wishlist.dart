import 'package:flutter/cupertino.dart';
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
        backgroundColor: Colors.purple,
      ),
      body: new Container(
        color: Colors.white,
        margin: EdgeInsets.only(bottom: 250),
        child: Column(
          children: [
            Expanded(
              child: new ListView.builder(
                itemBuilder: (_, int index) => EachList(),
                itemCount: 1,
              ),
            ),
            Expanded(
              child: new ListView.builder(
                itemBuilder: (_, int index) => EachList2(),
                itemCount: 1,
              ),
            ),
            Expanded(
              child: new ListView.builder(
                itemBuilder: (_, int index) => EachList3(),
                itemCount: 1,
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
          color: Colors.purpleAccent,
          border: Border.all(width: 5.0, color: Colors.purpleAccent),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        margin: EdgeInsets.all(0),
        padding: EdgeInsets.all(8.0),
        child: new Row(
          children: [
            Container(
              child: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('images/masker.jpg'),
              ),
              padding: EdgeInsets.only(right: 50.0),
            ),
            Text('Masker', style: TextStyle(fontSize: 20.0)),
          ],
        ),
      ),
    );
  }
}

class EachList2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new Container(
        decoration: BoxDecoration(
          color: Colors.purpleAccent,
          border: Border.all(width: 5.0, color: Colors.purpleAccent),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        margin: EdgeInsets.all(0),
        padding: EdgeInsets.all(8.0),
        child: new Row(
          children: [
            Container(
              child: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('images/momogi.jpg'),
              ),
              padding: EdgeInsets.only(right: 50.0),
            ),
            Text('Momogi', style: TextStyle(fontSize: 20.0)),
          ],
        ),
      ),
    );
  }
}

class EachList3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new Container(
        decoration: BoxDecoration(
          color: Colors.purpleAccent,
          border: Border.all(width: 5.0, color: Colors.purpleAccent),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        margin: EdgeInsets.all(0),
        padding: EdgeInsets.all(8.0),
        child: new Row(
          children: [
            Container(
              child: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('images/jeans.jpg'),
              ),
              padding: EdgeInsets.only(right: 50.0),
            ),
            Text('Jeans', style: TextStyle(fontSize: 20.0)),
          ],
        ),
      ),
    );
  }
}
