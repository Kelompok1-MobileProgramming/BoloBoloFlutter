import 'package:flutter/material.dart';
import 'package:bolobolo/home.dart';
import 'package:bolobolo/server.dart' as server;
import 'package:bolobolo/pages/signin.dart';

void main() {
  server.start();
  runApp(
    new MaterialApp(debugShowCheckedModeBanner: false, home: SignInPage()),
  );
}
