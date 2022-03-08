import 'package:buyenergy/authentication/login.dart';
import 'package:buyenergy/dashboard.dart';
import 'package:buyenergy/getstarted_page.dart';
import 'package:buyenergy/home_page_navigation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.


  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn=false;

@override
void initState() {
  super.initState();
  _checkIfLoggedIn();
}

  void _checkIfLoggedIn() async{
    //check if token exist
    SharedPreferences localStorage =await SharedPreferences.getInstance();
    var token= localStorage.getString('token');
    print(token);
    if(token !=null){
      setState(() {
        _isLoggedIn=true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
      // _isLoggedIn? 
      // HomePageNavagation() : 
      GetStartedPage(),
      // Login(),
    );
  }
}

