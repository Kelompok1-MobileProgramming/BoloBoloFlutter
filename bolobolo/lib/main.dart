import 'package:flutter/material.dart';
import 'package:flutter_demo/home.dart';
import 'package:flutter_demo/server.dart' as server;

void main() {
  server.start();
  runApp(
    new MaterialApp(debugShowCheckedModeBanner: false, home: HomePage()),
  );
}
