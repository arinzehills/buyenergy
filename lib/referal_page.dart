import 'package:buyenergy/components/my_text_field.dart';
import 'package:buyenergy/components/myoval_gradient_button.dart';
import 'package:buyenergy/constants/constants.dart';
import 'package:flutter/material.dart';

import 'components/gradient_text.dart';
import 'components/mypop_widget.dart';

class ReferalPage extends StatefulWidget {
  ReferalPage({Key? key}) : super(key: key);

  @override
  State<ReferalPage> createState() => _ReferalPageState();
}

class _ReferalPageState extends State<ReferalPage> {
  
  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    return  Scaffold(
            // drawer: MyDrawer(userid:widget.user_id,username: widget.username,),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                    children: [
                      Container(
                        height:size.height*0.3 ,
                      decoration:   BoxDecoration(
                              borderRadius: BorderRadius.vertical(bottom: Radius.circular(50)),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [myLightPurple,myPurple]
                              ),
                            
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                GradientText( 'Your referal code',
                              style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              ),
                              gradient:LinearGradient(
                              begin: Alignment.centerRight,
                              end: Alignment.bottomRight,
                              colors: myOrangeGradient,
                              
                                )
                              ),
                                SizedBox(height: 20,),
                                    Text(
                                '58Yxa6sed',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  ),
                                ),
                                SizedBox(height: 20,),
                                  Padding(
                                    padding:  EdgeInsets.only(left:38.0, right: 38),
                                    child: Text(
                                        'Copy your referral code and give it to family '+
                                        'and freinds to enter and get a bonus instantly ',
                                        style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                            ],
                          ),
                          ),
                      ),
                      SizedBox(height: 59,),
                    Column(
                      children: [
                        GradientText( 'Enter friends referal code to get reward',
                              style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              ),
                              gradient:LinearGradient(
                              begin: Alignment.centerRight,
                              end: Alignment.bottomRight,
                              colors: myOrangeGradient,
                              
                                )
                              ),
                      SizedBox(height: 29,),
                      Padding(
                        padding:  EdgeInsets.only(left:18.0,right: 18),
                        child: MyTextField(hintText: 'Enter code',
                        autovalidate: false,
                        ),
                      ),
                      SizedBox(height: 29,),
                        MyOvalGradientButton
                        (
                         placeHolder: 'Get Reward',
                         pressed: (){
                           Widget comingsoonwidget()=>
                                        Column(
                                          children: [
                                            Container(
                                                  padding: EdgeInsets.all(0.0),
                                                  height: 145,
                                                  child:
                                                    Image.asset('assets/dullbaby.png')
                                              ),
                                          ]);
                            myPopUp(
                               context,
                               'Your phone number has been recharged! ',
                               comingsoonwidget() );                                          
                                        
                         },
                          firstcolor: myLightOrange,
                           secondcolor: myOrange
                           ),

                      ],
                    )
                  ],
                ),
              )
             )              
          );
  }
}