import 'package:buyenergy/constants/my_navigate.dart';
import 'package:flutter/material.dart';

import '../home_page_navigation.dart';

const  appId="0282cdbc-0b53-4f12-b9c9-4762e3ebedc2";
final iconsColor=const Color(0xffffffff);
final myLightPurple= const Color(0xff6500ff);
final myPurple= const Color(0xff3a0667);
final myLightOrange= const Color(0xffffbd60);
final myOrange= const Color(0xffff8303);
final forminputPurple= const Color(0xff900fff);

final myOrangeGradient= [const Color(0xffff8303),const Color(0xffffbd60)];
final myblueGradient= [const Color(0xff02edff),const Color(0xff239eca)];
final mypurpleGradient= [const Color(0xff6500ff),const Color(0xff3a0667)];
final mygreenGradient= [const Color(0xff70ffb8),const Color(0xff72ff71)];
 Size size(context)=> MediaQuery.of(context).size;
var textFieldDecoration = InputDecoration(
                                   hintStyle: TextStyle(
                                     color:const  Color(0xff626262)),
                                  filled: true,
                                  fillColor:const  Color(0xfff7f7f7),
                                  focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10.0),
                                 ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10.0),
                                    ), 
);
var secondtextFieldDecoration = InputDecoration(
                                   hintStyle: TextStyle(
                                     color:const  Color(0xff626262)),
                                  filled: true,
                                  fillColor:const  Color(0xfff7f7f7),
                                  focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10.0),
                                 ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10.0),
                                    ),
                                     
);
     snackBar(page,context,text){
         MyNavigate.navigatejustpush(page, context);
                                          ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                          SnackBar(
                                            backgroundColor: myLightOrange,
                                            content: Text(
                                              text ?? 'Logged In Successfully')
                                              )
                                        );
     }
      snackBaruntil(page,context,text){
         MyNavigate.navigateuntil(page, context);
                                          ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                          SnackBar(
                                            backgroundColor: myLightOrange,
                                            content: Text(
                                              text ?? 'Logged In Successfully')
                                              )
                                        );
     }
currentuser(context){
      // final user= Provider.of<MyUser>(context);
      // return user;
}