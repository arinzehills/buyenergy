

import 'package:buyenergy/components/gradient_text.dart';
import 'package:buyenergy/constants/constants.dart';
import 'package:flutter/material.dart';

class NoAccount extends StatelessWidget {
  String title;
  String? subtitle;
  Function()? pressed;
  NoAccount({
   required this.title, this.pressed, this.subtitle
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title ,
        style:TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold
          )
        ),
        SizedBox(width: 10,),
        GestureDetector(
          onTap:pressed,
          child:GradientText(
            subtitle ?? '',
            style: const TextStyle(
                    fontSize: 25
                    ),
             gradient:LinearGradient(
                  begin: Alignment.centerRight,
                    end: Alignment.bottomRight,
                  colors: myOrangeGradient,
                )
                )
        )
      ],
    );
  }
}