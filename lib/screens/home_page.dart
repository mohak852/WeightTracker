

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weighttrackerapp/Services/authSerive.dart';
import 'package:weighttrackerapp/screens/main_page.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  final AuthService _authService = AuthService();
  void signIn() async {
    await _authService.signInWithGoogle();
    final String userName = await _authService.getUserName();
    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>MainPage(text: userName)));
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        bottomOpacity: 10.0,
        brightness: Brightness.dark,
        centerTitle: true,
        title: Text("Simple Weight Tracker App",style: TextStyle(
          fontFamily: 'DMMono',
          fontWeight: FontWeight.normal,
          color: Colors.teal,
        ),),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              FlutterLogo(
                style: FlutterLogoStyle.stacked,
                size: 350.0,
              ),
              SizedBox(height: 100.0,),
              SizedBox(height: 20.0,),
              GestureDetector(
                onTap: (){
                  signIn();
                },
                  child: Container(
                    height: 50.0,
                    width: 350.0,
                    decoration: BoxDecoration(
                      color: Colors.black,
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                    ),
                      child:Center(child: Text("Sign In With Google",style: TextStyle(
                        fontSize: 25.0,
                        fontFamily: 'DMMono',
                        color: Colors.teal,
                      ),),),
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
