import 'package:flutter/material.dart';
import '../screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var materialApp2 = MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chats',
      theme: ThemeData(
        primaryColor: Color(0xffaf01ce),
      ),
      home: HomeScreen(),
    );
    var materialApp = materialApp2;
    return materialApp;
  }
}
