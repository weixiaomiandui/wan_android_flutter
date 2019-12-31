import 'package:flutter/material.dart';
import 'package:wan_android/navigator/tab_navigator.dart';
import 'package:wan_android/navigator/tab_navigator.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'WanAndroid',
      theme: ThemeData(
        primarySwatch:Colors.blue
      ),
      home: TabNavigator(),
    );
  }
}