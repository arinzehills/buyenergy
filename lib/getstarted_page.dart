import 'package:buyenergy/authentication/login.dart';
import 'package:buyenergy/constants/my_navigate.dart';
import 'package:flutter/material.dart';

import 'authentication/register.dart';
import 'components/gradient_text.dart';
import 'components/my_button.dart';
import 'components/my_gradient_button.dart';
import 'constants/constants.dart';


class GetStartedPage extends StatefulWidget {
  GetStartedPage({Key? key, }) : super(key: key);


  @override
  _GetStartedPageState createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  var welcomepageLightBlue;



  @override
  Widget build(BuildContext context){
    Size size= MediaQuery.of(context).size;
          return Scaffold(
  body: SafeArea(
      child: SingleChildScrollView(
    child: Stack(
     
      children:[ 
      //    Positioned(
      //   top: -321,
      //   right: -139,
      //   child: Image.asset(
      //     'assets/mycurve.png',
      //     width:size.height * 0.805,
      //     height:1000,
      //     ),
      // ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        
        children: [
          
          Padding(
            padding: const EdgeInsets.only(top:139.0),
            child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Container(
                    padding: EdgeInsets.all(0.0),
                    height: 50,
                     child:
                      Image.asset('assets/logo_transparent.png',)
                ),
                SizedBox(height: 10,),
                GradientText(
                  'GET STARTED',
                  style: const TextStyle(
                    fontSize: 35
                    ),
                  gradient: LinearGradient(
                     begin: Alignment.centerRight,
                    end: Alignment.bottomRight,
                    colors:myOrangeGradient),
                ),
                
                  Text(
                  '...buying  energy units made easier and faster',
                  style: TextStyle(
                    color: const Color(0xffffb00b),
                    fontSize: 15
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
                     height: MediaQuery.of(context).size.height * 0.1,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [myLightPurple,myPurple]
                )
                 ),
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.only(top:125.0),
              child: Column(
                children: [

                MyGradientButton(
                  placeHolder: 'Sign in',
                  firstcolor:myPurple,
                  secondcolor:myLightPurple,
                  // firstcolor:const Color(0xff019bf9) ,
                  // secondcolor:const Color(0xff0b6dff),
                  pressed: (){
                    MyNavigate.navigatejustpush(Login(), context);
                  },
                  ),
                  MyButton(
                  placeHolder: 'Register',
                  pressed: () async{
                MyNavigate.navigatejustpush(Register(), context);
                    
                  },
                ),

                ],
              ),
            ),
          )
        ],
      ),
      ]
    ),
  )),
);
  }
}