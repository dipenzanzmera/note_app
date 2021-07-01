import 'package:flutter/material.dart';
import 'package:notes_app/screen/AddNotes.dart';
import 'package:notes_app/screen/HomePage.dart';
import 'package:notes_app/screen/LoginPage.dart';
import 'package:notes_app/screen/ProfilePage.dart';
import 'package:notes_app/screen/RegistrationPage.dart';
import 'package:notes_app/screen/UpdateTask.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home:LoginPage(),
      routes: {
        "LoginPage" : (BuildContext context) => LoginPage(),
        "RegistrationPage" : (BuildContext context) => RegistrationPage(),
        "HomePage" : (BuildContext context) => HomePage(),
        "AddNotes" : (BuildContext context) => AddNotes(),
        "UpdateNotes" : (BuildContext context) => UpdateTask(),
        "ProfilePage" : (BuildContext context) => ProfilePage(),
      },
    );
  }
}