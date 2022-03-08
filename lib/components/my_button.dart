import 'package:buyenergy/constants/constants.dart';
import 'package:flutter/material.dart';

import 'gradient_text.dart';


class MyButton extends StatelessWidget {
  String placeHolder;
  final VoidCallback pressed;
  
  MyButton({
    required this.placeHolder, required this.pressed,
  });
  

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
                              child: SizedBox(
                                width: double.infinity,
                                height: 50.0,
                                child:RaisedButton(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  onPressed: pressed,
                                  color: Colors.white,
                                  child:GradientText(
                 placeHolder,
                  style: const TextStyle(
                    fontSize: 23
                    ),
                  gradient: LinearGradient(
                     begin: Alignment.centerRight,
                    end: Alignment.bottomRight,
                    colors: [
                     myLightPurple,
                    myPurple   
                    
                  ]),
                ),
                //  Text(
                //                     placeHolder,
                //                       style:TextStyle(
                //                         color:const Color(0xff0170ff),
                                        
                //                       ),

                //                   ),
                                ),

                                ),
    );
  }
}