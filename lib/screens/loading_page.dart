import 'dart:async';

import 'package:flutter/material.dart';
class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
  }
  startTime() async {
  var _duration = new Duration(seconds: 3);
  return new Timer(_duration, navigationPage);
  }
  void navigationPage(){
    Navigator.of(context).pushReplacementNamed('/HomePage');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/loadingscreen.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Simple Weight Tracker App",style: TextStyle(
              fontFamily: 'DMMono',
              fontSize: 25.0,
              fontWeight: FontWeight.bold
                ),
              ),
            SizedBox(height: 150.0,),
            CircularProgressIndicator(
              backgroundColor: Colors.transparent,
              strokeWidth: 2.0,
            )
          ],
        ),
        ),
        ),
    );
  }
}
