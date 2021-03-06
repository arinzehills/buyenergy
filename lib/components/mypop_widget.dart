
import 'package:buyenergy/constants/constants.dart';
import 'package:buyenergy/constants/my_navigate.dart';
import 'package:flutter/material.dart';

import 'myoval_gradient_button.dart';



  myPopUp(context,heading,Widget? children){
      
      int count=0;
      return showDialog(
        context: context,
        builder:(context)=>AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          content: Container(
            height: 214,          
            child: Center(
              child: Column(
                children: [
                      //             Ink(
                      //   decoration: const ShapeDecoration(
                      //     color: Colors.blue,
                      //     shape: CircleBorder(),
                      //   ),
                      //   child: ImageIcon(
                      //                     AssetImage('assets/logo_transparent.png'),
                      //                       size: 58,
                      //                       color: Colors.white,
                      //                     ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(bottom:17.0,top: 9),
                        child: Text(
                        heading,                  
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      children!,
                          ],
              ),
            ),
          ),
        ),
      );
    }