import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weighttrackerapp/Services/authSerive.dart';
import 'button_page.dart';
import 'package:percent_indicator/percent_indicator.dart';
class MainPage extends StatefulWidget {
  final String text;
  MainPage({Key key, @required this.text}) : super(key: key);
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    getIntValuesSF();
    getGoalValuesSF();
    super.initState();
  }
  void updateGoal(){
    setState(() {
      getGoalValuesSF();
      getIntValuesSF();
    });
  }
  int intValue = 0;

  Widget _progressTracker(){
    return CircularPercentIndicator(
            radius: 100.0,
            lineWidth: 10.0,
            percent: 0.9,
            center: Text("90%"),
            circularStrokeCap: CircularStrokeCap.round,
            backgroundColor: Colors.grey,
            maskFilter: MaskFilter.blur(BlurStyle.solid, 3),
            linearGradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black, Colors.teal],
            ),
          );
  }
  getIntValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return int
    setState(() {
      intValue = prefs.getInt('intWeightValue');
    });
  }
  int goalValue = 0;
  getGoalValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return int
    setState(() {
      goalValue = prefs.getInt('intGoalValue');
      print("Goal Value is "+goalValue.toString());
    });
  }

  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        bottomOpacity: 10.0,
        brightness: Brightness.dark,
        centerTitle: true,
        title: Container(
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text("${widget.text}",style: TextStyle(
              fontFamily: 'DMMono',
              fontWeight: FontWeight.normal,
              color: Colors.teal,
          ),),
            ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Container(
                height: 350.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [BoxShadow(
                    blurRadius: 5.0,
                    offset: Offset(0, 5),
                    color: Colors.grey,
                  )],
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 50.0,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Colors.black,
                          Colors.black87,
                        ]),
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),topRight: Radius.circular(10.0))
                      ),
                      child:Center(
                        child: Text("Weight Loss Progress",style: TextStyle(
                          fontFamily: 'DMMono',
                          fontSize: 20.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.teal,
                        ),),
                      ),
                    ),
                    SizedBox(height: 70.0,),
                    Center(child: _progressTracker()),
                  ],
                ),
              ),
              SizedBox(height: 20.0,),
              Container(
                padding: EdgeInsets.all(20.0),
                height: 120.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),
                      bottomLeft: Radius.circular(5.0),
                      bottomRight: Radius.circular(5.0),
                    ),
                  boxShadow: [BoxShadow(
                    blurRadius: 5.0,
                    offset: Offset(0, 5),
                    color: Colors.grey,
                  )],
                  color: Colors.black,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(intValue.toString()!=null?intValue.toString():0,style: TextStyle(
                          fontFamily: 'DMMono',
                          fontSize: 20.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.teal,
                        ),),
                        SizedBox(height: 10.0,),
                        Text("Current \n Weight",style:TextStyle(
                          fontFamily: 'DMMono',
                          fontSize: 15.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.teal,
                        ),),
                      ],
                    ),
                    SizedBox(
                      width: 30.0,
                      child: VerticalDivider(
                        thickness: 1.0,
                        color: Colors.teal,
                      ),),
                    Column(
                      children: <Widget>[
                        Text(goalValue.toString()!=null?goalValue.toString():0,style: TextStyle(
                          fontFamily: 'DMMono',
                          fontSize: 20.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.teal,
                        ),),
                        SizedBox(height: 10.0,),
                        Text("Goal ",style:TextStyle(
                          fontFamily: 'DMMono',
                          fontSize: 15.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.teal,
                        ),),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0,),
              Container(
                height: 60.0,
                width: 350.0,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [BoxShadow(
                    blurRadius: 5.0,
                    offset: Offset(0, 5),
                    color: Colors.grey,
                  )],
                ),
                child: ListTile(
                  leading: Icon(Icons.history,color: Colors.teal,),
                  title: Text("History",style:TextStyle(
                    fontFamily: 'DMMono',
                    fontSize: 20.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.teal,
                  ),),
                  trailing: FlatButton(
                    onPressed: (){
                      Navigator.of(context).pushNamed('/HistoryPage');
                    },
                      child: Icon(Icons.arrow_forward,color: Colors.teal)),
                ),
              ),
              SizedBox(height: 30.0,),
              Container(
                padding: EdgeInsets.all(20.0),
                height: 350.0,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.teal,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [BoxShadow(
                    blurRadius: 5.0,
                    offset: Offset(0, 5),
                    color: Colors.grey,
                  )],
                ),
                child: Sparkline(
                  data:  [0.0, 1.0, 1.5, 2.0, 0.0, 0.0, -0.5, -1.0, -0.5, 0.0, 0.0],
                  lineColor: Colors.black,
                  fillMode: FillMode.below,
                  fillColor: Colors.transparent,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(context,MaterialPageRoute(
                builder: (context) => ButtonPage()
            ));
          },
        backgroundColor: Colors.black,
        child: Icon(Icons.add,color: Colors.teal),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
