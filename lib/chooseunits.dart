import 'package:buyenergy/constants/constants.dart';
import 'package:flutter/material.dart';

import 'buynits/buynits.dart';
import 'components/myoval_gradient_button.dart';
import 'constants/my_navigate.dart';
import 'home_page_navigation.dart';

Future popUp(context,user_id){
    
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
                                Ink(
                      decoration: ShapeDecoration(
                        gradient: LinearGradient(
                          colors: mypurpleGradient,
                          ),
                        shape: CircleBorder(),
                      ),
                      child: ImageIcon(
                                        AssetImage('assets/chooseunits.png'),
                                          size: 58,
                                          color: Colors.white,
                                        ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom:17.0,top: 9),
                      child: Text(
                  'Buy units',                  
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            RadiantGradientMask(
                              child: IconButton(
                                  icon: ImageIcon(
                                            AssetImage('assets/buyunits.png'),
                                              size: 68,
                                              color: Colors.white,
                                            ),
                                  color: Colors.white,
                                  onPressed: (){
                                    MyNavigate.navigatejustpush(
                                      BuyUnits(unitType: 'Energy',user_id: user_id,), context);
                                  },
                                  )
                                ),
                                  Padding(
                                  padding: const EdgeInsets.only(bottom:17.0,top: 9),
                                  child: Text(
                              'Energy units',                  
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                                      ],
                        ),
                           Column(
                          children: [ IconButton(
                                  icon: ImageIcon(
                                            AssetImage('assets/water.png'),
                                              size: 68,
                                              color: Colors.blue,
                                            ),
                                  color: Colors.white,
                                  onPressed: (){
                                  
                                    MyNavigate.navigatejustpush(BuyUnits(unitType: 'Water',user_id: user_id,), context);
                                  },
                                  ),
                                  Padding(
                                  padding: const EdgeInsets.only(bottom:17.0,top: 9),
                                  child: Text(
                              'Water units',                  
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                                      ],
                        ),
                      ],
                    )
                    // MyOvalGradientButton(placeHolder: 'A Course',
                    //                    firstcolor: myPurple, secondcolor: myLightPurple
                    //                    , pressed: (){
                    //                      MyNavigate.navigateandreplace(BuyUnits(unitType: 'energy'), context);
                    //                    }),
                    //             SizedBox(height: 14),
                    // MyOvalGradientButton(placeHolder: 'A File', 
                    //       firstcolor: myPurple, secondcolor: myLightPurple,
                    //       pressed: (){
                    //         MyNavigate.navigateandreplace(BuyUnits(unitType: 'Water'), context);
                    //       },
                    //       ),
                         ],
            ),
          ),
        ),
      ),
    );
  }

 
  