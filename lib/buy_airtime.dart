import 'dart:convert';

import 'package:buyenergy/buynits/models/energy_model.dart';
import 'package:buyenergy/components/drawer.dart';
import 'package:buyenergy/components/gradient_text.dart';
import 'package:buyenergy/components/my_text_field.dart';
import 'package:buyenergy/components/myoval_gradient_button.dart';
import 'package:buyenergy/components/normal_curve_container.dart';
import 'package:buyenergy/constants/constants.dart';
import 'package:buyenergy/constants/loading.dart';
import 'package:buyenergy/constants/my_navigate.dart';
import 'package:buyenergy/services/buynit_service.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'buynits/buynits.dart';
import 'buynits/order_summary.dart';
import 'components/mypop_widget.dart';
import 'home_page_navigation.dart';

class BuyAirtime extends StatefulWidget {
  final user_id;
  final username;
  final email;
  final String unitType;
  const BuyAirtime({ Key? key,required this.user_id,required this.unitType,this.username ,this.email}) : super(key: key);

  @override
  _BuyAirtimeState createState() => _BuyAirtimeState();
}

class _BuyAirtimeState extends State<BuyAirtime> {
  
   
   String selectbiller = 'Select biller';
   List<String> billertype=['Select biller','mtn','glo','airtel', 'etisalat'];



   String amount = '0';
   String phone = '';
   String serviceID = '';
  final _formKey = GlobalKey<FormState>();
  String billingTypeError='';
  String billerError='';
  String error='';
  bool showError=false;
      bool loading=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    if(billingTypeError!=''){
          setState(() {
            showError=true;
          });
        }else{
          setState(() {
            showError=false;
          });
        }
     Size size= MediaQuery.of(context).size;
    print('selectbiller1 '+selectbiller);
    return loading ? Loading() : Scaffold(
      drawer: MyDrawer(),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
               NormalCurveContainer(
                 pagetitle: 'Buy '+ widget.unitType ,
                 size: size, height: size.height* 0.44,container_radius: 120,
                 widget: Padding(
                   padding: const EdgeInsets.only(left:18.0,right: 18),
                   child: atmCard(size,amount,widget.username ?? '',),
                 ),),
                                   Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 10.0, top: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [                                                                 
                             billerTypeWidget(),
                              // showError==true ? errorWidget(billingTypeError):SizedBox(),
                               errorWidget(billingTypeError),
                                MyTextField(
                                    // validator:  MultiValidator(
                                    //       [
                                    //         RequiredValidator(errorText: 'Required'),
                                    //         MinLengthValidator(8, errorText: 'meter number must be 11 digits long'),
                                    //       ]
                                    //     ),
                                  autovalidate: true,
                                   keyboardType: TextInputType.number,
                                  hintText: 'Phone', 
                                  onChanged: (val){
                                    setState(() {
                                      phone=val;
                                        });
                                  },
                                                        
                                  ),
                                  SizedBox(
                                        height:15,
                                    ),
                                        
                                    SizedBox(
                                        height:15,
                                    ),
                             MyTextField(
                               hintText: '(#) Amount',
                               validator: (val)=> val!.isEmpty ? 'enter amount' : null,
                               keyboardType: TextInputType.number,
                               autovalidate: true,
                               onChanged: (val) async {
                                    setState(() {
                                      amount=val;
                                        });
                                        print(val.length);
                                      
                                  },
                               ),
                                Text(error, style: TextStyle(color: Colors.red),),
                                    SizedBox(
                                        height:15,
                                    ),
                    Center(
                      child: MyOvalGradientButton(
                        placeHolder: 'Continue', pressed: _buyAirtime,
                        firstcolor: myPurple, secondcolor: myLightPurple),
                    )
                    ],
                  ),
                ),
                )
              ],
            ),
          ),
        ),
      
    );
  }

  _buyAirtime() async {
        setState(() {
          loading =true;
        });
     var response=await BuyService().buyAirtime(phone, selectbiller, amount,widget.user_id);
                                                var body= json.decode(response.body);                      
                                                print(response.body);
                                                 if(body['success']==true){                                                   
                                                     print(body['requestId']);                                                  
                                                      setState(() => loading=false);
                                                      _showPopUp();
                                                }else{
                                                setState(() => loading=false);
                                                setState(() => error=body['error'].toString());
                                                
                                                }
  }
  _showPopUp(){
   Widget widget()=> Column(
                        children: [
                           Container(
                                  padding: EdgeInsets.all(0.0),
                                  height: 155,
                                  child:
                                    RadiantGradientMask(
                                      child: ImageIcon(
                                        AssetImage(
                                          'assets/dullbaby.png',),
                                          size: 60,color: Colors.white,),
                                    )
                              ),
                              MyOvalGradientButton(
                                placeHolder: 'Buy again',
                                 pressed: (){Navigator.pop(context);},
                                  firstcolor: myLightOrange, 
                                  secondcolor: myOrange)
                        ],
                      );
                      myPopUp(context, 'Success', widget());
  }
   Widget errorWidget(error)=>  Padding(
                                              padding: const EdgeInsets.only(left:12.0,top: 0),
                                              child: Text(
                                                error,
                                                style: TextStyle(
                                                  color:Colors.red
                                                ),
                                              ),
                                            );
  validate(buyenergyinfo){
    if(_formKey.currentState!.validate()){ 
                      setState(() { error='';selectbiller='';});
                     if(selectbiller=='Select biller'){
                                          //no package seleceted
                                          setState(() {
                                            billerError='Please select biller';
                                          });
                                        }else{ 
                                          setState(() {billingTypeError='';});
                                          }
                                    if(selectbiller=='Select billing type'){
                                          //no package seleceted
                                          setState(() {
                                            billingTypeError='Please select a billingtype';
                                          });
                                        } else{
                                          setState(() {
                                          billingTypeError='';
                                        });
                                        
                                        MyNavigate.navigatejustpush(
                                          OrderSummary(buyenergyinfo:buyenergyinfo
                                              ), context);
                                        }  
                                  }else{
                                    setState(() {
                                                            error='Please enter missing input(s)';
                                                          });
                                  }
                    
  }
  
       Widget billerTypeWidget(){
         return Padding(
       padding: const EdgeInsets.all(18.0).copyWith(left: 1,right: 1),
       child: Container(
         height: 50,
         padding: EdgeInsets.only(left: 25,right: 25),
         decoration: BoxDecoration(
          //  border: Border.all(color: Colors.grey, width: 1),
          color: myLightPurple.withOpacity(0.2),
           borderRadius: BorderRadius.circular(12)
           
         ),
         child: DropdownButton<String>(
           dropdownColor: myLightOrange,
          value: selectbiller,
          icon: const Icon(
            Icons.expand_more,
            color: Colors.grey,
            ),
          iconSize: 24,
          elevation: 16,
          isExpanded: true,
          style: const TextStyle(color: Colors.grey),
          underline: SizedBox(),
          onChanged: (String? newValue) {
            setState(() {
             selectbiller= newValue!;
              // print('selectbilltype'+selectbiller);
            });
          },
          items:billertype
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
            );
          }).toList(),
    ),
       ),
     );
       }
}
 