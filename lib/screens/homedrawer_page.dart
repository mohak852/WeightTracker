import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class HomeDrawer extends StatefulWidget {
  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  int _selectedIndex;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.black,
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Center(child: Text("Simple Weight Tracker",style: TextStyle(
                fontSize: 22.0,
                fontFamily: 'DMMono',
              ),),),
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.teal,
                boxShadow: [BoxShadow(
                  color: Colors.teal.shade900,
                  offset: Offset(0, 5),
                )],
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                leading: Icon(Icons.arrow_forward),
                title: Text("Progress Bar"),
                trailing: Icon(Icons.arrow_forward)
              ),
            ),
            Divider(
              height: 5.0,
              thickness: 2.0,
              color: Colors.white,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                  leading: Icon(Icons.arrow_forward),
                  title: Text("History"),
                  trailing: Icon(Icons.arrow_forward)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
