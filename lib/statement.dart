
import 'dart:convert';

import 'package:buyenergy/buynits/models/transactions_model.dart';
import 'package:buyenergy/components/custom_sliver_delegate.dart';
import 'package:buyenergy/components/drawer.dart';
import 'package:buyenergy/components/gradient_text.dart';
import 'package:buyenergy/components/my_gradient_button.dart';
import 'package:buyenergy/components/mylist_container.dart';
import 'package:buyenergy/constants/constants.dart';
import 'package:buyenergy/constants/loading.dart';
import 'package:buyenergy/services/transactions_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Statement extends StatefulWidget {
  final int user_id;
  const Statement({ Key? key ,required this.user_id,}) : super(key: key);

  @override
  _StatementState createState() => _StatementState();
}

class _StatementState extends State<Statement> {
    int show=1;
    var userData;
    var userToken;
    var userid;
    bool loading=false;
    var instance=TransactionService.transactionInstance;
    
  late Future<TransactionsModel> _transactions_data;

@override
   void initState() {
    _getUserInfo();
    super.initState();
    
    
    refreshTransactionList();
    // var index = widget.index;
  }
    Future refreshTransactionList() async {
    setState(() => loading= true);

    //this.students = await TransactionService.
      //              transactionInstance.getUserTransactions(1);
      this._transactions_data = TransactionService
                .transactionInstance.getUserTransactions(widget.user_id);
    setState(() => loading = false);
  }
    @override
  void dispose() {
    
    TransactionService.transactionInstance;

    super.dispose();
  }
void _getUserInfo() async{
                      SharedPreferences localStorage= await SharedPreferences.getInstance();

                      var userJson=localStorage.getString('user');
                      var token=localStorage.getString('token');
                      setState(() {
                        userToken=token;
                      });
                      //print(userJson);
                      var user=json.decode(userJson.toString());
                      setState(() {
                        userData=user;
                      });
    }

  @override
  Widget build(BuildContext context) {
     Size size= MediaQuery.of(context).size;
    int empty=0;
      // final value = context.
        return FutureBuilder(
          future: _transactions_data,
          builder: (context, AsyncSnapshot snapshot) {
             if(snapshot.hasError){
                print('sdhasdfbgu '+snapshot.error.toString());
                return Text(snapshot.error.toString());
            }else
            if(snapshot.data==null){
               
           
              return Loading();
            }else{
              List<dynamic> transactions_items = snapshot.data!.transactions;
            return  Scaffold(
                  drawer: MyDrawer(),
                  body: SafeArea(
                      child: Stack(
                        children: [
                          CustomScrollView(
                            slivers: <Widget>[
                              SliverPersistentHeader(
                                  pinned: true,
                                  floating: true,
                                  delegate: CustomSliverDelegate(
                                    expandedHeight: 149,
                                    showLogo: false,
                                    aligncontainerwidget: MyListContainer(
                                      title: 'Total Amount spent',
                                      // sub_title: snapshot.data!.size.toString(),
                                      sub_title: snapshot.data!.total_amount.toString(),
                                      ),
                                    showaligncontainerwidget:true,
                                    title: 'Transactions history',
                                    alignment: Alignment(0.0, 1.40),
                                    curveContainerHeight: size.height * 0.33,
                                     widget1: Padding(
                                    padding: const EdgeInsets.only(left:33.0, top: 5),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top:18.0),
                                     child:userData==null? Loading(): GradientText( userData['name'],
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
                                ),
                              SliverToBoxAdapter(
                                child: Center(
                                      child:   transactions_items.length==0  ? Padding(
                                                  padding:  EdgeInsets.only(top: size.height * 0.140),
                                                  child: Container(
                                                    height: size.height * 0.31,
                                                 width: size.width*0.7,
                                                decoration: BoxDecoration(
                                                  
                                                borderRadius: BorderRadius.all(Radius.circular(100)),                
                                                boxShadow: [
                                                              BoxShadow(
                                                                color: myLightPurple.withOpacity(0.24),
                                                                spreadRadius: 15,
                                                                blurRadius: 50,
                                                                offset: Offset(0, 9), // changes position of shadow
                                                              ),
                                                            ],
                                                gradient: LinearGradient(
                                                        begin: Alignment.topLeft,
                                                        end: Alignment.bottomRight,
                                                        colors: [ Colors.white,Colors.white]
                                                      )
                                                ),
                                                child:  Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      ClipRRect(
                                                                    borderRadius: BorderRadius.all(Radius.circular(50)),                                        
                                                                    child: Image.asset(
                                                                      "assets/dullbaby.png",
                                                                      height: 160,
                                                                      )
                                                              ),
                                                              Text(' No transactions yet', )
                                                                              
                                                    ],
                                                  ) 
                                        ),
                                      ):
                                   Wrap(
                                     children: [
                                      
                                      Container(
                                        height: 50,
                                      ),

                                      
                                      
                                       ListView.builder(
                                             itemCount: transactions_items.length,
                                             shrinkWrap: true,
                                             padding: EdgeInsets.only(top: 10,bottom: 10),
                                             physics: NeverScrollableScrollPhysics(),
                                             itemBuilder: (context, index){
                                               return Padding(
                                            padding: const EdgeInsets.only(top: 10.0,left: 30, right: 30),
                                            child: 
                                         GestureDetector(
                                          onTap: (){
                                            // MyNavigate.navigatejustpush(UploadListPage(isUser:false,), context);
                                          },
                                          child: Container(
                                                          height: 90,
                                                          width: size.width* 0.85,                  
                                                            decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(20)),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.2),
                                              blurRadius: 30,
                                              spreadRadius: 0,
                                              offset: Offset(10,30)
                                            )
                                          ]
                                                            ),  
                                                              child: MyListContainer(
                                                                title: transactions_items[index]['product_name'] + " - N" + transactions_items[index]['amount'].toString(),
                                                                //title: 'Buy Units:34 ',
                                                              titleColor: Colors.black,
                                                              sub_title: transactions_items[index]['created_at'].replaceAll("T"," ").split(".")[0],
                                                              )
                                                          ),
                                        ),                      
                                          );
                                             }
                                             ),
                                     ],
                                   ),
                                ),
                              ),
                            ],
                          ),
                      //      Positioned(
                            
                      //   child: Padding(              
                      //     padding: EdgeInsets.only(
                      //       top:size.height*0.8),
                      //     child: Center(           
                      //     child: MyGradientButton(
                      //       placeHolder: 'Upload', 
                      //       pressed: (){
                      //           // popUp(context);
                      //           // MyNavigate.navigatejustpush(UploadFiles(), context);
                      //       }, 
                      //       firstcolor: myLightOrange,
                      //        secondcolor: myOrange,
                      //        child:Padding(
                      //                                    padding: const EdgeInsets.only(left:18.0),
                      //                                    child: ImageIcon(
                      //                                     AssetImage('assets/Transaction_blue.png'),
                      //                                       size: 30,
                      //                                       color: Colors.white,
                      //                                     ),
                      //                                  ),
                      //        )
                      // ),
                      //   )
                      //    )
                          ]
                      ),
                    ),
                  
                  );
                  }
          }
        );
         

  }
   Widget SwithButton(name)=> Padding(
                    padding: const EdgeInsets.only( left:34.0, top:40 ),
                    child: Row(                      
                       mainAxisAlignment:  MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 80,
                      height: 50,
                      decoration: BoxDecoration(                        
                        gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [ myPurple,myLightPurple]
                                         ),                                      
                        borderRadius: BorderRadius.all(Radius.circular(100)), 
                         boxShadow: [
                                                          BoxShadow(
                                                            color: myPurple.withOpacity(0.24),
                                                            // spreadRadius: 5,
                                                            blurRadius: 10,
                                                            offset: Offset(0, 5), // changes position of shadow
                                                          ),
                                                        ],
                     ),
                     child: Center(
                         child: Text(
                           name,
                           style: TextStyle(
                             color: Colors.white,
                             fontSize: 15
                           ),
                         )
                     ),
                  
               ),
     ],
   ),
 );
}