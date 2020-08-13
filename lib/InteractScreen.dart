import 'package:flutter/material.dart';

class InteractScreen extends StatelessWidget{
    static Route<dynamic> route() => MaterialPageRoute(builder: (context) => InteractScreen(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("InteractScreen"),
      ),
      body: Center(
        child: Text("Welcome to Interaction Screen",
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
