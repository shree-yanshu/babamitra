import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'Data.dart';
import 'GetDataFromFirebase.dart';

class ConsoleScreen extends StatefulWidget{
  static Route<dynamic> route() => MaterialPageRoute(builder: (context) => ConsoleScreen(),
  );
  @override
  _ConsoleScreenState createState() => _ConsoleScreenState();
}

class _ConsoleScreenState extends State<ConsoleScreen> {

  List<Data> allData = [];

  @override
  void initState() {
    DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
    databaseReference.child('data').once().then((DataSnapshot snap) {
      var keys = snap.value.keys;
      var data = snap.value;
      allData.clear();
      for (var key in keys) {
        Data d = new Data(
          data[key] ['fullname'],
        );
        allData.add(d);
      }

      setState(() {
        print('Length: ${allData.length}');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Console"),
      ),
      body: Container(
          child: allData.length == 0
              ? Text('No Data is available')
              : ListView.builder(
            itemCount: allData.length,
            itemBuilder: (_, index) {
              return UI(
                allData[index].fullname,
              );
            },
          )
      ),
    );
  }

  Widget UI(String fullname) {
    return ListTile(
      title: InkWell(
        child: Text('$fullname', style: TextStyle(
          fontSize: 20.0,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => GetDataFirebase()),
          );
        },
      ),
    );
  }
}