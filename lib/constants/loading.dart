import 'package:buyenergy/components/gradient_text.dart';
import 'package:buyenergy/constants/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';


class Loading extends StatelessWidget {
  String? title;
  Loading({this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Center(
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpinKitCubeGrid(
                color: myOrange,
                size: 50.0,
               ),
               SizedBox(height: 5,),
               GradientText(title ?? 'Processing...', 
               gradient: LinearGradient(colors: mypurpleGradient)
               ,style:TextStyle(
                  fontSize: 15,
                  decoration: TextDecoration.none
               ),
               ),
            ],
          ),
        ),
    );
  }
}