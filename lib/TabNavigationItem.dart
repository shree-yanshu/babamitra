import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'RegisterScreen.dart';
import 'InteractScreen.dart';
import 'ConsoleScreen.dart';

class TabNavigationItem {
  final Widget page;
  final Widget title;
  final Icon icon;

  TabNavigationItem({
    @required this.page,
    @required this.title,
    @required this.icon,
  });

  static List<TabNavigationItem> get items => [
    TabNavigationItem(
      page: RegisterScreen(),
      icon: Icon(Icons.details,color: Colors.white,),
      title: Text("Register", style: TextStyle(color: Colors.white,),),
    ),
    TabNavigationItem(
      page: InteractScreen(),
      icon: Icon(Icons.chat,color: Colors.white,),
      title: Text("Interact",style: TextStyle(color: Colors.white,),),
    ),
    TabNavigationItem(
      page: ConsoleScreen(),
      icon: Icon(Icons.backup,color: Colors.white,),
      title: Text("Console",style: TextStyle(color: Colors.white,),),
    ),
  ];
}
