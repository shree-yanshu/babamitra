import 'dart:collection';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';


class RegisterScreen extends StatefulWidget{
    static Route<dynamic> route() => MaterialPageRoute(builder: (context) => RegisterScreen(),
  );

    @override
    _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>{

  Geolocator geolocator = Geolocator();


  File imageFile;
  var formkey = GlobalKey<FormState>();

  Position userLocation;
  String fullname, petname, cast, landmark, locality, problem, contact, alternative, facebook;
  String _radioValue; //Initial definition of radio button value
  String choice;
  String _radioValue2; //Initial definition of radio button value
  String choice2;


  final casts = ["Thakur", "Brahmin", "Yadav", "Jatav", "Jaat"];
  String dropdownValue = 'Thakur';
  final religion = ["Hindu", "Sikh", "Cristian", "Muslim"];
  String dropdownValue1 = 'Hindu';

  @override
  void initState() {
    super.initState();
    _getLocation().then((position) {
      userLocation = position;
    });
  }


  Future<Position> _getLocation() async {
    var currentLocation;
    try {
      currentLocation = await geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    } catch (e) {
      currentLocation = null;
    }
    return currentLocation;
  }


  void radioButtonChanges(String value) {
    setState(() {
      _radioValue = value;
      switch (value) {
        case 'uneducated':
          choice = value;
          break;
        case 'high school':
          choice = value;
          break;
        case 'intermediate':
          choice = value;
          break;
        case 'graduation':
          choice = value;
          break;
        case 'post graduation':
          choice = value;
          break;
        default:
          choice = null;
      }
      debugPrint(choice); //Debug the choice in console
    });
  }

  void radioButtonChanges2(String value) {
    setState(() {
      _radioValue2 = value;
      switch (value) {
        case 'yes':
          choice2 = value;
          break;
        case 'no':
          choice2 = value;
          break;
        default:
          choice2 = null;
      }
      debugPrint(choice2); //Debug the choice in console
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("image"),
      ),
      body: Form(
        key: formkey,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(top: 15.0)),
                
                CircleAvatar(
                  backgroundColor: Colors.black12,
                  radius: 80.0,
                    child: imageFile == null ?
                    FlatButton(
                        onPressed: () {
                          _showDialog();
                        },
                        child: Icon(Icons.add_a_photo, size: 35.0, color: Colors.red,)
                    ) :
                    Container(
                      width: 160.0,
                      height: 160.0,
                      decoration:  BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image:  FileImage(imageFile)
                          )
                      )
                    ),

                ),

                SizedBox(height: 10,),

                SizedBox(height: 5,),

                TextFormField(
                  // ignore: missing_return
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please, enter your full name";
                    } else {
                      fullname = value;
                    }
                  },
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      icon: const Icon(Icons.person, color: Colors.red,),
                      hintText: 'Enter your full name',
                      hintStyle: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                      labelText: 'Full Name',
                      labelStyle: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      )
                  ),
                ),


                SizedBox(height: 5,),

                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please, enter your pet name";
                    } else {
                      petname = value;
                    }
                  },
                  decoration: InputDecoration(
                      icon: const Icon(Icons.home, color: Colors.red,),
                      hintText: 'Enter your pet name',
                      hintStyle: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                      labelText: 'Pet Name',
                      labelStyle: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      )
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(  20.0),
                  child: DropdownButtonFormField(
                    value: dropdownValue,
                    icon: Icon(Icons.arrow_downward, color: Colors.red,),
                    decoration: InputDecoration(
                        labelText: "Select your Cast",
                        labelStyle: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        )
                    ),
                    items: casts.map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value,
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Select your Cast';
                      }
                      return null;
                    },
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(  20.0),
                  child: DropdownButtonFormField(
                    value: dropdownValue1,
                    icon: Icon(Icons.arrow_downward, color: Colors.red,),
                    decoration: InputDecoration(
                        labelText: "Select your Religion",
                        labelStyle: TextStyle(
                          fontSize: 20.0,
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        )
                    ),
                    items: religion.map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue1 = newValue;
                      });
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Select your Religion';
                      }
                      return null;
                    },
                  ),
                ),

                Padding(
                    padding: const EdgeInsets.only(top: 10.0,right: 240.0),
                    child: Text("Select your Education",
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    )),

                Row(
                  children: <Widget>[
                    Radio(
                      value: 'uneducated',
                      groupValue: _radioValue,
                      onChanged: radioButtonChanges,
                    ),
                    Text(
                      "Uneducated",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Radio(
                      value: 'high school',
                      groupValue: _radioValue,
                      onChanged: radioButtonChanges,
                    ),
                    Text(
                      "High School",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Radio(
                      value: 'intermediate',
                      groupValue: _radioValue,
                      onChanged: radioButtonChanges,
                    ),
                    Text(
                      "intermediate",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                Row(
                  children: <Widget>[
                    Radio(
                      value: 'graduation',
                      groupValue: _radioValue,
                      onChanged: radioButtonChanges,
                    ),
                    Text(
                      "graduation",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),


                    Radio(
                      value: 'post graduation',
                      groupValue: _radioValue,
                      onChanged: radioButtonChanges,
                    ),
                    Text(
                      "Post Graduation",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                TextFormField(
                  maxLines: 4,
                  // ignore: missing_return
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please, enter your landmark";
                    } else {
                      landmark = value;
                    }
                  },
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      icon: const Icon(Icons.landscape,color: Colors.red,),
                      hintText: 'Enter Here',
                      hintStyle: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                      labelText: 'Enter your Landmark',
                      labelStyle: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      )
                  ),
                ),

                TextFormField(
                  maxLines: 4,
                  // ignore: missing_return
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please, enter your locality";
                    } else {
                      locality = value;
                    }
                  },
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      icon: const Icon(Icons.streetview,color: Colors.red,),
                      hintText: 'Enter Here',
                      hintStyle: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                      labelText: 'Enter your Locality',
                      labelStyle: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      )
                  ),
                ),

                TextFormField(
                  maxLines: 4,
                  // ignore: missing_return
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please, enter your problems";
                    } else {
                      problem = value;
                    }
                  },
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      icon: const Icon(Icons.report_problem,color: Colors.red,),
                      hintText: 'Enter Here',
                      hintStyle: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                      labelText: 'Enter your Problems(Social)',
                      labelStyle: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      )
                  ),
                ),

                Padding(
                    padding: const EdgeInsets.only(top: 10.0, right: 250.0),
                    child: Text("Any Known Person",
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    )),


                Row(
                  children: <Widget>[
                    Radio(
                      value: 'yes',
                      groupValue: _radioValue2,
                      onChanged: radioButtonChanges2,
                    ),
                    Text(
                      "Yes",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Radio(
                      value: 'no',
                      groupValue: _radioValue2,
                      onChanged: radioButtonChanges2,
                    ),
                    Text(
                      "No",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                TextFormField(
                  // ignore: missing_return
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please, enter your what's app number";
                    } else {
                      contact = value;
                    }
                  },
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      icon: const Icon(Icons.phone,color: Colors.red,),
                      hintStyle: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                      labelText: 'Contact Number(Whats App)',
                      labelStyle: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      )
                  ),
                  keyboardType: TextInputType.phone,
                ),

                TextFormField(
                  // ignore: missing_return
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please, enter your alternative number";
                    } else {
                      alternative = value;
                    }
                  },
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      icon: const Icon(Icons.phone,color: Colors.red,),
                      hintText: 'Enter your number',
                      hintStyle: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                      labelText: 'Alternative Number(Optional)',
                      labelStyle: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      )
                  ),
                  keyboardType: TextInputType.phone,
                  inputFormatters: [

                  ],
                ),

                TextFormField(
                  // ignore: missing_return
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please, enter your facebook link";
                    } else {
                      facebook = value;
                    }
                  },
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      icon: const Icon(Icons.landscape,color: Colors.red,),
                      hintText: 'Enter Here',
                      hintStyle: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                      labelText: 'Facebook Link(Optional)',
                      labelStyle: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      )
                  ),
                ),

                SizedBox(height: 10,),

                RaisedButton(
                  color: Colors.teal,
                  onPressed: () {
                    if (imageFile == null) {
                      Fluttertoast.showToast(msg: "Please, select an image",
                          gravity: ToastGravity.CENTER,
                          toastLength: Toast.LENGTH_LONG,
                          timeInSecForIosWeb: 2
                      );
                    } else {
                      upload();
                    }
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text("Upload",
                    style: TextStyle(fontSize: 18.0, color: Colors.white),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showDialog() {
    return showDialog(context: context, builder: (BuildContext) {
      return AlertDialog(
        title: Text("Upload Image"),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                child: Text("Gallary",
                  style: TextStyle(fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  openGallery();
                },
              ),

              Padding(padding: EdgeInsets.all(10.0),),
              GestureDetector(
                child: Text("Camera",
                  style: TextStyle(fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),),
                onTap: () {
                  openCamera();
                },
              ),
            ],
          ),
        ),
      );
    },
    );
  }

  Future<void> openGallery() async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = picture;
    });
  }

  Future<void> openCamera() async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = picture;
    });
  }

  Future<void> upload() async {
    _getLocation();
    if(formkey.currentState.validate()){
      StorageReference reference = FirebaseStorage.instance.ref().child("images");
      StorageUploadTask uploadTask = reference.putFile(imageFile);
      var imageUrl = await(await uploadTask.onComplete).ref.getDownloadURL();
      String url= imageUrl.toString();
      DatabaseReference databaseReference = FirebaseDatabase.instance.reference().child("data");
      String uploadId = databaseReference.push().key;
      // ignore: deprecated_member_use
      HashMap map = new HashMap();
      map["fullname"] = fullname;
      map["petname"] = petname;
      map["imgUrl"] = url;
      map["cast"] = dropdownValue;
      map["religion"] = dropdownValue1;
      map["education"] = choice;
      map["landmark"] = landmark;
      map["locality"] = locality;
      map["problem"] = problem;
      map["whats_app_number"] = contact;
      map["alternative_number"] = alternative;
      map["facebook_link"] = facebook;
      map["latitude"] = userLocation.latitude;
      map["longitude"] = userLocation.longitude;
      databaseReference.child(uploadId).set(map);
    }
  }

}