
import 'dart:convert';
import 'dart:io';

import 'package:buyenergy/buynits/models/energy_model.dart';
import 'package:buyenergy/components/gradient_text.dart';
import 'package:buyenergy/components/myoval_gradient_button.dart';
import 'package:buyenergy/components/mypop_widget.dart';
import 'package:buyenergy/components/normal_curve_container.dart';
import 'package:buyenergy/constants/constants.dart';
import 'package:buyenergy/constants/loading.dart';
import 'package:buyenergy/constants/my_navigate.dart';
import 'package:buyenergy/services/buynit_service.dart';
import 'package:flutter/material.dart';
import 'package:flutterwave/core/flutterwave.dart';
import 'package:flutterwave/utils/flutterwave_currency.dart';

import '../home_page_navigation.dart';
import 'buynits.dart';


class OrderSummary extends StatefulWidget {
  final Energy buyenergyinfo;
  const OrderSummary({ Key? key, required this.buyenergyinfo }) : super(key: key);

  @override
  _OrderSummaryState createState() => _OrderSummaryState();
}
class OrderModel{
  String title;
  String? value;
  OrderModel({required this.title, this.value,});

}
class _OrderSummaryState extends State<OrderSummary> {
    var orderInfo;
    bool loading=false;

  _getOrderInfo(){
     List<OrderModel> ordersummary =[
            OrderModel(title: 'Customer name',value:widget.buyenergyinfo.customername),
            OrderModel(title: 'Address',value:widget.buyenergyinfo.address),
            OrderModel(title: 'Phone',value:widget.buyenergyinfo.phone),
            OrderModel(title: 'Biller type',value:widget.buyenergyinfo.billType),
            OrderModel(title: 'Biller',value:widget.buyenergyinfo.biller),
            OrderModel(title: 'Meter number',value:widget.buyenergyinfo.meternumber),
            OrderModel(title: 'Amount',value:widget.buyenergyinfo.amount),
          ];
     setState(() {
       orderInfo=ordersummary;
     });
  }
 
  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }

    return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
  }
  @override
  void initState() {
    // TODO: implement initState
    _getOrderInfo();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
     Size size= MediaQuery.of(context).size;

    return loading==true ? Loading() : Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top:12.0),
          child: Column(
            children: [
             NormalCurveContainer(
                 pagetitle: 'ORDER SUMMARY',
               size: size, height: size.height* 0.49,container_radius: 140,
               widget: Padding(
                 padding: const EdgeInsets.only(left:18.0,right: 18),
                 child: atmCard(size,widget.buyenergyinfo.amount,widget.buyenergyinfo.username),
                ),
               ),
                                 Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 10.0, top: 20),
              child: Container(
                            decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),                
                            boxShadow: [
                                          BoxShadow(
                                            color: myPurple.withOpacity(0.6),
                                            // spreadRadius: 5,
                                            blurRadius: 10,
                                            offset: Offset(0, 5), // changes position of shadow
                                          ),
                                        ],
                            color: Colors.white,
                            ),
                            child: Column(
                              children: [
                            
                                ListView.builder(
                              itemCount: orderInfo.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.only(top: 28),
                              physics:ScrollPhysics(),
                              itemBuilder: (context, index){
                                return Padding(
                                  padding: const EdgeInsets.only(top:12.0, left: 20, right: 20),
                                  child: Column(
                                    children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(orderInfo[index].title ??'', style: TextStyle(fontWeight: FontWeight.w500),),
                                            Text(orderInfo[index].value ??'', style: TextStyle(fontWeight: FontWeight.w300),),
                                          ],
                                        )
                                    ],
                                  ),
                                );
                              },
                                ),
                                 Padding(
                                   padding: const EdgeInsets.only(bottom:20,top: 20),
                                   child: Center(
                                    child: MyOvalGradientButton(
                                      placeHolder: 'Pay ', pressed: _onPressed, 
                                      firstcolor: myPurple, secondcolor: myLightPurple),
                                ),
                                 ),
                                
                              ],
                            ) ,
                )
              )
            ],
          ),
        ),
      ),
    );
  }
  _onPressed() {
    
      this._handlePaymentInitialization();
    
  }

  _handlePaymentInitialization() async {
    final flutterwave = Flutterwave.forUIPayment(
      amount: widget.buyenergyinfo.amount,
      currency: FlutterwaveCurrency.NGN,
      context: this.context,
      publicKey: "FLWPUBK_TEST-b6fec30caf684ee6845762074efb8ce3-X",
      encryptionKey: 'FLWSECK_TESTa753a5576d98',
      email: widget.buyenergyinfo.email.toString(),
      fullName: widget.buyenergyinfo.customername.toString(),
      txRef: DateTime.now().toIso8601String(),
      narration: "Example Project",
      isDebugMode: true,
      phoneNumber: widget.buyenergyinfo.phone.toString(),
      // acceptAccountPayment: true,
      acceptCardPayment: true,
      // acceptUSSDPayment: true
    );
    final response = await flutterwave.initializeForUiPayments();
    if (response != null) {
      
      print(response.data!.status);
      setState(() {
        loading =true;
      });
      if(response.data!.status=='successful'){
            var res=await BuyService().
                        buyElectricity(
                        widget.buyenergyinfo.meternumber, 
                        widget.buyenergyinfo.biller.substring(0,widget.buyenergyinfo.biller.indexOf('(')),
                          widget.buyenergyinfo.billType,
                          widget.buyenergyinfo.phone,
                          widget.buyenergyinfo.amount,
                          widget.buyenergyinfo.user_id);
                          var body= json.decode(res.body);                      
                          print(res.body);
                  if(body['success']==true){    
                                setState(() {
                                  loading =false;
                                });                                               
                                print(body['purchased_code']);
                                print(body['units']);
                                this.showLoading('Success ' ,body['purchased_code'] + ' '
                                +body['units']);
                                     
                                     }else{
                                       this.showLoading('Failed',body['response_description'] + ' '
                                     +body['error']);
                                     }
                               }else{//no card payment success

                               }
          
    } else {
      this.showLoading("No Response!",null);
    }
  }
    showLoading(String title, String? message, ){
    Widget widget()=> Column(
                        children: [
                           Container(
                                  padding: EdgeInsets.all(0.0),
                                  height: 155,
                                  child:
                                        Image.asset(
                                          'assets/dullbaby.png',
                                          height: 60,
                                          ),
                              ),
                              GradientText(
                                message ?? '', 
                                gradient:LinearGradient(colors: myOrangeGradient)  ),
                              MyOvalGradientButton(
                                placeHolder: 'Buy again',
                                 pressed: (){Navigator.pop(context);},
                                  firstcolor: myLightOrange, 
                                  secondcolor: myOrange)
                        ],
                      );
                      myPopUp(context, title, widget());
    }
}
class OrderInfo{
  final String status;
  final String request_id;
  final String bonus;
  final String? units;
  final String purchased_code;

  OrderInfo({
    this.status='success',
    required this.request_id,
    required this.bonus,
     this.units,
     required this.purchased_code,
  });

}