
import 'dart:convert';

import 'package:buyenergy/components/myoval_gradient_button.dart';
import 'package:buyenergy/constants/constants.dart';
import 'package:buyenergy/statement.dart';
import 'package:buyenergy/transactions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'authentication/login.dart';
import 'authentication/profile.dart';
import 'dashboard.dart';


class HomePageNavagation extends StatefulWidget {
      final int? index;

  const HomePageNavagation({ Key? key, this.index }) : super(key: key);

  @override
  _HomePageNavagationState createState() => _HomePageNavagationState();
}

class _HomePageNavagationState extends State<HomePageNavagation> {

   late int _selectedIndex = widget.index ?? 0;
    var userData; 
 

@override
  void initState() {
    _getUserInfo();
    super.initState();
    // var index = widget.index;
  }
void _getUserInfo() async{
                      SharedPreferences localStorage= await SharedPreferences.getInstance();

                      var userJson=localStorage.getString('user');
                      var user=json.decode(userJson!);
                      setState(() {
                        userData=user;
                      });
}
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    }

  //  Future <bool> _onBackPressed(){
    
  //   return showDialog(
  //     context: context,
  //     builder:(context)=>AlertDialog(
  //       title:Text('Do You want to Exit'),
  //       actions: <Widget>[
  //         MyOvalGradientButton(placeHolder: 'No',
  //          pressed: ()=> Navigator.pop(context,false),
  //           firstcolor: myLightOrange, secondcolor: myOrange
  //           ),
  //         MyOvalGradientButton(placeHolder: 'Yes',
  //          pressed: ()=> Navigator.pop(context,true),
  //           firstcolor: myLightOrange, secondcolor: myOrange)
          
  //       ]
  //     ),
  //   ).then((value) => value);
     
  // }
     Future <bool> _onBackPressed(){
    
    return Navigator.of(context).push(
                     MaterialPageRoute(builder: (context) => Login()),
                     ).then((value) => value);
  }

  @override
  Widget build(BuildContext context) {
     List<Widget> _widgetOptions = <Widget>[
    Dashboard(user_id: userData['id'],),
    Transaction(user_id: userData['id'],),
    Statement(user_id: userData['id'],),
    // (),
    Profile()    
  ];
    return  WillPopScope(
               onWillPop: ()=>_onBackPressed(),
              child: Scaffold(
                //  drawer: MyDrawer(),
                bottomNavigationBar:BottomNavigationBar(              
                items:<BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.dashboard,
                        size: 25,
                      ),
                    label: 'Dashboard',                
                    activeIcon: RadiantGradientMask(
                      child: Icon(
                          Icons.dashboard_customize_outlined,
                          size: 30,
                          color: Colors.white,
                          )
                        )
                  ),
                  BottomNavigationBarItem(
                    icon:  ImageIcon(
                      AssetImage('assets/history.png'),
                        size: 30,
                      ),
                    label: 'Transactions',
                    activeIcon: RadiantGradientMask(
                      child: Icon(
                          Icons.history,
                          size: 30,
                          color: Colors.white,
                          )
                        ),
                  ),
                  BottomNavigationBarItem(
                    icon:  ImageIcon(                  
                      AssetImage(
                        'assets/account.png',
                        ),
                        size: 30,
                      ),
                    label: 'Finacial statement',
                       activeIcon: RadiantGradientMask(
                      child: Icon(
                          Icons.money,
                          size: 30,
                          color: Colors.white,
                          )
                        ),
                  ),
                     
                   BottomNavigationBarItem(
                    icon:  ImageIcon(
                      AssetImage('assets/user.png'),
                        size: 30,
                      ),
                    label: 'Profile',
                       activeIcon: RadiantGradientMask(
                      child: Icon(
                          Icons.account_circle,
                          size: 30,
                          color: Colors.white,
                          )
                        ),
                  ),
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: myLightPurple,
                unselectedItemColor: Colors.grey[400],
                onTap: _onItemTapped,
                
              ),
               body: _widgetOptions.elementAt(_selectedIndex),
            
      ),
    );
  }
}
class RadiantGradientMask extends StatelessWidget {

  RadiantGradientMask({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return RadialGradient(
          center: Alignment.bottomLeft,
          radius: 0.5,
          colors: <Color>[
            
            myLightOrange,
            myOrange,
            myLightOrange,

          ],
          tileMode: TileMode.mirror,
        ).createShader(bounds);
      },
      child: child,
    );
  }
}