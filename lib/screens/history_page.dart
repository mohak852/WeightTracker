import 'package:flutter/material.dart';
import '../model/db_helper.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final dbHelper = DatabaseHelper.instance;
  List weightList = [];
  String currWeightUnit = " kg";
  @override
  void initState() {
    initPrefs();
    super.initState();
  }

  void initPrefs() async {
    weightList = await dbHelper.queryAllRows();
    print(weightList);
    print(weightList.length);
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text(
          "History",
          style: TextStyle(
            fontFamily: 'DMMono',
            fontWeight: FontWeight.normal,
            color: Colors.teal,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: weightList.length,
          itemBuilder: (BuildContext context, indice) {
            DateTime parsedTime = DateTime.parse(weightList[indice]["time"]);
//            DateFormat("dd-MM-yyyy").format(now),
             String goal = weightList[indice]["goal"].toString();
             String weight = weightList[indice]["weight"].toString();
            double totalProgress =  weightList.isEmpty
                ? 0.0
                : (weightList.first.weight - weightList.last.weight);
            double currentWeight =  weightList.isEmpty ? 0.0 : weightList.first.weight;
            return Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(20.0),
                  height: 100.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(25.0),
                    boxShadow: [BoxShadow(
                      color: Colors.grey,
                      offset: Offset(2, 3),
                      spreadRadius: 2.0,
                    )],
                  ),
                  child: Column(
                    children: <Widget>[
                      Text("Goal: " + goal,style: TextStyle(
                        fontFamily: 'DMMono',
                        fontWeight: FontWeight.normal,
                        color: Colors.teal,
                      ),),
                      SizedBox(height: 5.0,),
                      Text("Weight: " + weight,style: TextStyle(
                        fontFamily: 'DMMono',
                        fontWeight: FontWeight.normal,
                        color: Colors.teal,
                      ),),
                      Text("Date: " + parsedTime.toString(),style: TextStyle(
                        fontFamily: 'DMMono',
                        fontWeight: FontWeight.normal,
                        color: Colors.teal,
                      ),),
                      Text("WeightDifference: " + totalProgress.toString(),style: TextStyle(
                        fontFamily: 'DMMono',
                        fontWeight: FontWeight.normal,
                        color: Colors.teal,
                      ),),
                    ],
                  ),
                ),
                SizedBox(height: 15.0,),
              ],
            );
          },
        ),
      ),
    );
  }
}