import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Lists.dart';

class GetDataFirebase extends StatefulWidget {
  @override
  _GetDataFirebaseState createState() => _GetDataFirebaseState();
}

class _GetDataFirebaseState extends State<GetDataFirebase> {
  List<Lists> allLists = [];

  @override
  void initState() {
    DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
    databaseReference.child('data').once().then((DataSnapshot snap) {
      var keys = snap.value.keys;
      var data = snap.value;
      allLists.clear();
      for (var key in keys) {
        Lists d = new Lists(
          data[key]['imgUrl'],
          data[key]['fullname'],
          data[key]['petname'],
          data[key]['cast'],
          data[key]['religion'],
          data[key]['education'],
          data[key]['landmark'],
          data[key]['locality'],
          data[key]['problem'],
          data[key]['whats_app_number'],
          data[key]['alternative_number'],
          data[key]['facebook_link'],
          data[key]['latitude'].toString(),
          data[key]['longitude'].toString(),
          data[key]['timestamp'].toString(),
        );
        allLists.add(d);
      }
      setState(() {
        print('Length: ${allLists.length}');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Console"),
      ),
      body: Container(
          padding: const EdgeInsets.only(top: 20.0),
          child: allLists.length == 0
              ? Text('No Data is available')
              : ListView.builder(
                  itemCount: allLists.length,
                  itemBuilder: (_, index) {
                    return UI(
                      allLists[index].imgUrl,
                      allLists[index].fullname,
                      allLists[index].petname,
                      allLists[index].cast,
                      allLists[index].religion,
                      allLists[index].education,
                      allLists[index].landmark,
                      allLists[index].locality,
                      allLists[index].problem,
                      allLists[index].whats_app_number,
                      allLists[index].alternative_number,
                      allLists[index].facebook_link,
                      allLists[index].latitude,
                      allLists[index].longitude,
                      allLists[index].timestamp,
                    );
                  },
                )),
    );
  }

  Widget UI(
      String imgUrl,
      String fullname,
      String petname,
      String cast,
      String religion,
      String education,
      String landmark,
      String locality,
      String problem,
      String whats_app_number,
      String alternative_number,
      String facebook_link,
      String timestamp,
      String latitude,
      String longitude) {
    return Card(
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              ClipOval(
                  child: Image.network(
                imgUrl,
                fit: BoxFit.contain,
                width: 210,
                height: 280,
              )),
              SizedBox(
                height: 20,
              ),
              Text(
                'Full Name : $fullname',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Pet Name : $petname',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Cast : $cast',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Religion : $religion',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Education : $education',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Landmark : $landmark',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Locality : $locality',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Problem : $problem',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Contact Number(Whats App) : $whats_app_number',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Alternative Number : $alternative_number',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Facebook Link : $facebook_link',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Latitude : $latitude',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Longitude : $longitude',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Timestamp : $timestamp',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
