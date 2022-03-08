import 'dart:convert';
import 'package:buyenergy/components/mypop_widget.dart';
import 'package:buyenergy/components/scrollgradient_text.dart';
import 'package:buyenergy/components/drawer.dart';
import 'package:buyenergy/components/gradient_text.dart';
import 'package:buyenergy/constants/constants.dart';
import 'package:buyenergy/constants/loading.dart';
import 'package:buyenergy/constants/my_navigate.dart';
import 'package:buyenergy/contact_us.dart';
import 'package:buyenergy/referal_page.dart';
import 'package:buyenergy/services/transactions_service.dart';
import 'package:buyenergy/statement.dart';
import 'package:buyenergy/transactionhistories/energy_breakdown.dart';
import 'package:buyenergy/transactions.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'authentication/profile.dart';
import 'buynits/buynits.dart';
import 'buynits/models/transactions_model.dart';
import 'components/Scroll_text.dart';
import 'components/my_curve_container.dart';
import 'components/myoval_gradient_button.dart';
import 'home_page_navigation.dart';

class Dashboard extends StatefulWidget {
  final  user_id;
  final String? username;
  const Dashboard({ Key? key,
            required this.user_id,
             this.username,
            }) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // get welcomepageBlue => null;
  late Future<TransactionsModel> _energy_data;
  late Future<TransactionsModel> _amount_data;
  double percent = 0.0;
  var userData;
    
    @override
   void initState() {
    refreshTransactionList();
     
    _getUserInfo();
    super.initState();
    // var index = widget.index;
  }
  
void _getUserInfo() async{
                      SharedPreferences localStorage= await SharedPreferences.getInstance();

                      var userJson=localStorage.getString('user');
                      print(userJson);
                      var user=json.decode(userJson.toString());
                      setState(() {
                        userData=user;
                      });
}
 Future refreshTransactionList() async {
      this._energy_data = TransactionService
                .transactionInstance.getUserEnergyUsage(widget.user_id);
     this._amount_data = TransactionService
                .transactionInstance.getUserTransactions(widget.user_id);
  }
  @override
  void dispose() {
    
    super.dispose();
  }

  List<CircleBuilder> circles=[
    CircleBuilder(title: 'Buy energy units',imageurl: 'power.png',
                  gradient:myblueGradient, shadowcolor: const Color(0xff02edff),iconcolor: Colors.white),
    CircleBuilder(title: 'Buy water units',iconcolor: myOrange,imageurl: 'water.png',shadowcolor:  Color(0xff02edff),),
    CircleBuilder(title: 'Order history',imageurl: 'history.png',iconcolor: myLightPurple,gradient:myOrangeGradient,shadowcolor: myLightOrange),
    CircleBuilder(title: 'Contact center',iconcolor: myOrange,imageurl: 'contact2.png',gradient:mypurpleGradient,shadowcolor: myLightPurple),
    CircleBuilder(title: 'Units consumption breakdown',iconcolor: Colors.white,imageurl: 'breakdown.png',gradient:myblueGradient,shadowcolor: const Color(0xff02edff)),
    CircleBuilder(title: 'Account statement',iconcolor: Colors.green[600],imageurl: 'account.png',gradient:mygreenGradient,shadowcolor: const Color(0xff70ffb8)),
    CircleBuilder(title: 'More: other bills',iconcolor: Colors.white,imageurl: 'more.png',gradient:myOrangeGradient,shadowcolor: const Color(0xff02edff)),
     CircleBuilder(title: 'Referrals & reward',iconcolor: myOrange,imageurl: 'contact2.png',shadowcolor:  Color(0xff02edff),),
  ];
  @override
  Widget build(BuildContext context) {
  double _height;
  double _width;
     Size size= MediaQuery.of(context).size;
    
          return  FutureBuilder(
            future: _amount_data,
          builder: (context, AsyncSnapshot snapshot) {
             if(snapshot.hasError){
                print('sdhasdfbgu '+snapshot.error.toString());
                return Text(snapshot.error.toString());
            }else
            if(snapshot.data==null){
               
           
              return Loading();
            }else{
            return  Scaffold(
            drawer: MyDrawer(userid:widget.user_id,username: widget.username,),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    
                    Builder(
                    builder:(context)=> Column(
                      children: [
                        MyCurveContainer(
                          size: size,
                          height: size.height * 0.35,
                          showLogo: true,
                          right_widget:  IconButton(
                                onPressed: ()=> {
                                  MyNavigate.navigatejustpush(Profile(), context)
                                  }, 
                                  icon: ImageIcon(
                                  AssetImage('assets/user.png'),
                                    size: 100,
                                    color:myOrange,
                                  ),
                               ),
                          curvecontainerwidget1: Padding(
                            padding: const EdgeInsets.only(left:33.0, top: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                             Padding(
                               padding: const EdgeInsets.only(top:18.0),
                               child:userData==null? Loading(): GradientText(userData['name']?? 'Hi Chris!',
                                style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                ),
                                gradient:LinearGradient(
                                begin: Alignment.centerRight,
                                end: Alignment.bottomRight,
                                colors: myOrangeGradient,
                                
                                )),
                             ),
                              ],
                            ),
                          ),
                          ),
                     Center(
                       child: Padding(
                                padding:  EdgeInsets.only(top: size.height * 0.19,left:size.width * 0.11,),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                    children: [
                              MySmallContainer(
                                circle: circles.first,
                                onClick: (){MyNavigate.navigatejustpush(
                                  BuyUnits(
                                    user_id: userData['id'],
                                    username: userData['name'],
                                  email: userData['email'], unitType:'energy'), context);},
                                    ),
                                      SizedBox( width: 10,),
                                      MySmallContainer(circle: circles[1], onClick: (){
                                       
                                       myPopUp(
                                         context,'This feature is coming soon',comingsoonwidget() );                                          
                                        }
                                        ),
                                    ]
                               ),
                                     Row(
                                       children: [
                                        MySmallContainer(circle: circles[2],
                                        onClick: (){MyNavigate.navigatejustpush(Transaction(user_id: userData['id'],), context);},
                                        ),
                                          SizedBox( width: 10,),
                                       MySmallContainer(circle: circles[3], onClick: (){
                                        
                                          showDialog(context: context,
                                            builder: (BuildContext context){
                                            return  Center(
                                                    child: ContactUs(
                                                        title: "CONTACT US",
                                                        )
                                            );
                                            }
                                            );
                                         }
                                          ),
                                    ]
                                    ),
                                     Row(
                                    children: [
                                      MySmallContainer(circle: circles[4],                                    
                                        scrollText: true,
                                        onClick: (){
                                        MyNavigate.navigatejustpush(EnergyBreakDown(user_id: userData['id'],), context);
                                        }
                                      ),
                                      SizedBox( width: 10,),
                                      MySmallContainer(circle: circles[5], onClick: (){
                                        MyNavigate.navigatejustpush(Statement(user_id: userData['id']), context);
                                        }
                                        ),
                                      ]
                                    ),
                                       Row(
                                    children: [
                                      MySmallContainer(
                                        circle: circles[6],
                                        onClick: () async{
                                          Widget more()=>
                                        Column(
                                          children: [
                                            GestureDetector(
                                              onTap: (){
                                              },
                                              child: Column(
                                                children: [
                                                  MyOvalGradientButton(
                                                    placeHolder: 'EV Charging',
                                                     pressed: (){
                                                        Navigator.pop(context);
                                                     myPopUp(
                                                      context,'This feature is coming soon',
                                                      comingsoonwidget() );                                          
                                        
                                                     
                                                     },
                                                      firstcolor:myOrange,
                                                     secondcolor: myLightOrange
                                                     ),
                                                     SizedBox(height: 20),
                                                     MyOvalGradientButton(
                                                    placeHolder: 'Buy Gas Units',
                                                     pressed: (){
                                                       Navigator.pop(context);
                                                     myPopUp(
                                                      context,'This feature is coming soon',
                                                      comingsoonwidget() );                                          
                                        
                                                     },
                                                      firstcolor:myOrange,
                                                     secondcolor: myLightOrange
                                                     )
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                        myPopUp(context, 'More', more());
                                        },
                                        ),
                                      SizedBox( width: 10,),
                                      MySmallContainer(
                                        circle: circles[7],
                                        scrollText: true,
                                        onClick: () async{
                                          MyNavigate.navigatejustpush(
                                            ReferalPage(), 
                                          context);
                                        },
                                        ),
                                    ]
                                  ),
                                  ],
                                ),
                              ),
                     ),
                      ],
                    ),
                  ),
                  
                   Positioned(
                      
                  child: Padding(              
                    padding: EdgeInsets.only(top: size.height * 0.20),
                    child: Center(
                 
                    child: Container(
                      height: 200,
                      width: size.width* 0.85,                  
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          color: Colors.white,
                           gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [myPurple,myLightPurple]
                              ),
                          boxShadow: [
                            BoxShadow(
                              color: myLightPurple.withOpacity(0.2),
                              blurRadius: 30,
                              spreadRadius: 10,
                              offset: Offset(10,30)
                            )
                          ]
                        ),  
                        child:  Wrap(
                          children: [
                            // Padding(
                            //   padding: const EdgeInsets.only(left:18.0, right:18, bottom: 1, top: 14),
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //     children: [
                            //       Text(
                            //           'mathematics'
                            //         ),
                            //          IconButton(
                            //             icon: Icon(Icons.expand_more),
                            //             color: Colors.blue,
                            //             onPressed: (){}
                            //           ),
                                      
                            //     ],
                            //   ),
                            // ),
                            Padding(
                              padding: const EdgeInsets.only(top:21.0,left:21,right: 22),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 150,
                                    child: Text(
                                        'Units used',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white
                                          ),
                                      ),
                                  ),
                                      Text(
                                        'Amount spent',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white
                                          ),
                                      ),
                                ],
                              ),
                            ),
                             Padding(
                              padding: const EdgeInsets.only(left:18.0, right: 18, top: 1),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  //  Container(
                                  //    width: 150,
                                  //    child: GradientText(
                                  //        'kWh 320.03 dsadaa',
                                  //         style: const TextStyle(
                                  //         fontSize: 30
                                  //         ), 
                                  //         gradient: LinearGradient(
                                  //           // colors: [myLightOrange,myLightOrange]
                                  //           colors: myOrangeGradient
                                  //            ),
                                  //         ),
                                  //  ),
                                   Expanded( 
                                     child: ScrollGradientText(
                                       snapshot.data!.total_units.toString()+ " kWh"
                                       , gradient: LinearGradient(
                                            // colors: [myLightOrange,myLightOrange]
                                            colors: myOrangeGradient
                                             ),),
                                   ),
                                   SizedBox(width: 20,),
                                    Expanded( 
                                     child: ScrollGradientText(
                                       ' N '+ snapshot.data!.total_amount.toString()
                                       , gradient: LinearGradient(
                                            // colors: [myLightOrange,myLightOrange]
                                            colors: myOrangeGradient
                                             ),),
                                   )
                                    //  GradientText(
                                    //    'N 3203',
                                    //     style: const TextStyle(
                                    //     fontSize: 30
                                    //     ), 
                                    //     gradient: LinearGradient(
                                    //       // colors: [myLightOrange,myLightOrange]
                                    //       colors: myOrangeGradient
                                    //        ),
                                    //     ),
                                ],
                              ),
                            ),
                             Padding(
                              padding: const EdgeInsets.only(left:18.0, top: 50,right: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SafeArea(
                                    child: MyOvalGradientButton(
                                      placeHolder: 'Check usage', 
                                      pressed: ()async{ 
                                     MyNavigate.navigatejustpush(
                                       EnergyBreakDown(user_id: userData['id'],), context);
          
                                      }, 
                                      firstcolor: myLightOrange, secondcolor: myOrange,),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                ),
                  )
                    ),
                  
                  ]
                ),
              ),
            ),
            );
            }
          }
          );
        
        
      
    // );
  }
   
  
 Widget comingsoonwidget()=>
                                        Column(
                                          children: [
                                            Container(
                                                  padding: EdgeInsets.all(0.0),
                                                  height: 155,
                                                  child:
                                                    Image.asset('assets/dullbaby.png')
                                              ),
                                            MyOvalGradientButton(placeHolder: 'OK',
                                                              firstcolor: myLightOrange, secondcolor: myOrange
                                                              , pressed: (){
                                                                Navigator.pop(context);
                                                              },                                              
                                                        ),
                                          ],
                                        );
}


class MySmallContainer extends StatelessWidget {
 CircleBuilder circle;
  final Function? onClick;
  bool? scrollText;
  MySmallContainer({
    Key? key,
    // required this.size,
    required this.circle,
    this.onClick,
    this.scrollText,
  }) : super(key: key);

  // final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(left:2.0, right: 12, bottom: 20),
      child: InkWell(
            onTap: () { 
                onClick!(); 
            },
        child: Column(
          children: [
            Container(
                height: 60,
                width: 60,
                             
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: Colors.white,
                  gradient: LinearGradient(colors:
                circle.gradient!=null? circle.gradient as List<Color>:[Colors.white,Colors.white]),
                  boxShadow: [
                    BoxShadow(
                      color: circle.shadowcolor!.withOpacity(0.45) ,
                      blurRadius: 20,
                      spreadRadius: 5,
                      offset: Offset(0,20)
                    )
                  ]
                ),   
                child: Center(
            child:   ImageIcon(
                    AssetImage('assets/'+ circle.imageurl.toString()),
                      size: 40,
                      color:circle.iconcolor,
                    ),
                          ),   
            ),
            SizedBox(height:13),
            Center(
            child: SizedBox(
              width: 120,
              child: Center(
                child: Wrap(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  
                  children: [
                  scrollText!=true ? 
                    Text(
                            circle.title ?? '',
                            // overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        )
                        : SizedBox(
                          height: 30,
                          child: ScrollingText(
                              text:  circle.title ?? '',
                              textStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                              scrollAxis: Axis.horizontal,
                            ),
                        ),
                  ],
                ),
              ),
            ),
              ),
          ],
        ),
      ),
    );
  }
}

class CircleBuilder{
    final String? title;
  final String? imageurl;
  final Color? shadowcolor;
  final Color? iconcolor;
  List<Color>? gradient;
  final Function? onClick;
  CircleBuilder({
    this.title, this.imageurl, this.shadowcolor, this.onClick, this.gradient,this.iconcolor
  });
}