
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:weighttrackerapp/Services/authSerive.dart';
import 'package:weighttrackerapp/model/db_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'main_page.dart';
class ButtonPage extends StatefulWidget {
  @override
  _ButtonPageState createState() => _ButtonPageState();
}

class _ButtonPageState extends State<ButtonPage> with SingleTickerProviderStateMixin{
  int weight = 0;
  int currentGoalValue = 0;
  String date = "",time = "";
  int currentIntValue = 0;
  DateTime selectedDate = DateTime.now();
  NumberPicker integerNumberPicker;
  final AuthService _authService = AuthService();
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }
  void savingGoal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('intGoalValue', currentGoalValue);
    print("the goal is saved " + currentGoalValue.toString());
  }
  void savingWeight() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('intWeightValue', currentIntValue);
  }

  Future _showIntDialog() async {
    await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return new NumberPickerDialog.integer(
          title: Text("Body Weight",style: TextStyle(
            fontFamily: 'DMMono',
            fontWeight: FontWeight.normal,
            color: Colors.teal,
          ),),
          minValue: 0,
          maxValue: 100,
          step: 1,
          initialIntegerValue: currentIntValue,
        );
      },
    ).then((num value) {
      if (value != null) {
        setState(() => currentIntValue = value);
        integerNumberPicker.animateInt(value);
      }
    });
  }
  Future _showGoalDialog() async {
    await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return new NumberPickerDialog.integer(
          title: Text("Enter your Goal",style: TextStyle(
            fontFamily: 'DMMono',
            fontWeight: FontWeight.normal,
            color: Colors.teal,
          ),),
          minValue: 0,
          maxValue: 100,
          step: 1,
          infiniteLoop: true,
          initialIntegerValue: currentGoalValue,
        );
      },
    ).then((num value) {
      if (value != null) {
        setState(() => currentGoalValue = value);
        integerNumberPicker.animateInt(value);
      }
    });
  }

  final dbHelper = DatabaseHelper.instance;
  var now = new DateTime.now();

  final firebaseDatabase  = Firestore.instance;
  void _saveButtonClk() async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnDatetime: DateTime.now().toString(),
      DatabaseHelper.columnWeight: currentIntValue,
      DatabaseHelper.columnGoal: currentGoalValue, 
    };
    final id = await dbHelper.insert(row);
    print(new DateFormat("dd-MM-yyyy").format(now));
    final String userName = await _authService.getUserName();
    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>MainPage(text: userName)));
    print("Inserted Record id: $id");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        bottomOpacity: 10.0,
        brightness: Brightness.dark,
        centerTitle: true,
        title: Text("Add Your Weight",style: TextStyle(
          fontFamily: 'DMMono',
          fontWeight: FontWeight.normal,
          color: Colors.teal,
        ),),
      ),
      body: Container(
        child: new Container (
    padding: const EdgeInsets.all(10.0),
            color: Colors.white,
            child: new Container(
            child: new Center(
            child: new Column(
                children : [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: ListTile(
                    title: Text("Enter Weight",style: TextStyle(
                      fontFamily: 'DMMono',
                      fontWeight: FontWeight.normal,
                      color: Colors.teal,
                    ),),
                       trailing: FlatButton(onPressed: (){
                             _showIntDialog();
            },
                         child: currentIntValue==0?Icon(Icons.line_weight,color: Colors.teal,):Text("${currentIntValue.toString()}",style: TextStyle(
                         fontFamily: 'DMMono',
                         fontSize: 20.0,
                         fontWeight: FontWeight.normal,
                         color: Colors.teal,
                       ),),
            ),
                      ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.black,
                    ),
                    child: ListTile(
                      title: Text("Select Date",style: TextStyle(
                        fontFamily: 'DMMono',
                        fontWeight: FontWeight.normal,
                        color: Colors.teal,
                      ),),
                      trailing: FlatButton(onPressed: (){
                        _selectDate(context);
                      }, child:Text("${selectedDate.toLocal()}".split(' ')[0],style: TextStyle(
                          fontFamily: 'DMMono',
                          fontSize: 18.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.teal,
                      ),),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: ListTile(
                      title: Text("Enter your Goal",style: TextStyle(
                        fontFamily: 'DMMono',
                        fontWeight: FontWeight.normal,
                        color: Colors.teal,
                      ),),
                      trailing: FlatButton(onPressed: (){
                        _showGoalDialog();
                      }, child: currentGoalValue==0?Icon(Icons.line_weight,color: Colors.teal,):Text("${currentGoalValue.toString()}",style: TextStyle(
                        fontFamily: 'DMMono',
                        fontSize: 20.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.teal,
                      ),),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.black,
                    ),
                    width: 150.0,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FlatButton(
                            onPressed: (){
                              _saveButtonClk();
                              savingGoal();
                              savingWeight();
                              print("Save button Presed");
                            },
                            child: Text("Save",style: TextStyle(
                                fontFamily: 'DMMono',
                                fontWeight: FontWeight.normal,
                                color: Colors.teal,
                                fontSize: 15.0
                            ),),
                          ),
                        ],
                      ),
                    ),
                  )
                  ],
                ),
            ),),
          ),
        ),
    );
  }
}
