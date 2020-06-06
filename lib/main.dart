import 'package:flutter/material.dart';
import 'package:weighttrackerapp/screens/button_page.dart';
import 'package:weighttrackerapp/screens/history_page.dart';
import 'package:weighttrackerapp/screens/home_page.dart';
import 'package:weighttrackerapp/screens/loading_page.dart';
import 'package:weighttrackerapp/screens/main_page.dart';
void main()=>runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/HomePage":(BuildContext context) => HomePage(),
        "/MainPage":(BuildContext context) => MainPage(),
        "/ButtonPage":(BuildContext context) => ButtonPage(),
        "/HistoryPage":(BuildContext context) => HistoryPage(),
      },
      debugShowCheckedModeBanner: false,
      home: LoadingScreen(),
    );
  }
}
