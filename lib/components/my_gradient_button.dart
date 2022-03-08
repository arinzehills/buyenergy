
import 'package:flutter/material.dart';


class MyGradientButton extends StatelessWidget {
  String placeHolder;
  final VoidCallback pressed;
  final  firstcolor;
  final  secondcolor;
  Widget? child;
  MyGradientButton({
    required this.placeHolder,
     required this.pressed,
    required this.firstcolor,
    required this.secondcolor,
    this.child,
  });
  

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
                                  onPressed:pressed,
                                   disabledColor: Colors.orange,
                                     disabledTextColor: Colors.white,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                                    padding: const EdgeInsets.all(0.0),
                                  child: Ink(
                                    width: MediaQuery.of(context).size.width* 0.9,
                                    height: 50,
                                  decoration:BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white
                                    ),
                                    gradient: LinearGradient(
                                     colors: [ firstcolor,secondcolor],
                                       begin: Alignment.topLeft,
                                     end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                  ),
                                   child: Container(
                                      constraints: const BoxConstraints(minWidth: 88.0, minHeight: 36.0), // min sizes for Material buttons
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            placeHolder,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                            color:Colors.white,
                                            fontSize: 23
                                          ),
                                          ),
                                          child ?? SizedBox(),                                         
                                        ],
                                      ),
                                    ),
                                  ),

    );
  }
}