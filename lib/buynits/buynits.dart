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

import 'order_summary.dart';


class BuyUnits extends StatefulWidget {
  final user_id;
  final username;
  final email;
  final String unitType;
  const BuyUnits({ Key? key,required this.unitType,
  required this.user_id,
  this.username ,this.email}) : super(key: key);

  @override
  _BuyUnitsState createState() => _BuyUnitsState();
}

class _BuyUnitsState extends State<BuyUnits> {
   String selectbiller = 'Select biller';
   var biller;
   
   String selectbilltype = 'Select billing type';
   List<String> billtype=['Select billing type','prepaid','postpaid'];

   _billerInfor(){
     List<String> billset=[selectbiller,'abuja-electric(AEDC)','eko-electric(EKEDC) ',
                        'ibadan-electric(IBEDC)','ikeja-electric(IKEDC)','jos-electric(JEDplc)',
                        'kaduna-electric(KAEDCO)','kano-electric(KEDCO)','portharcourt-electric(PHED)'];
    setState(() {
      biller=billset;
    });
    
    setState(() {
      selectbiller = 'Select biller';
    });
   }

   String meterNumber = '';
   String amount = '0';
   String phone = '';
  final _formKey = GlobalKey<FormState>();
  String billingTypeError='';
  String billerError='';
  String error='';
  bool showError=false;
      bool loading=false;

  @override
  void initState() {
    // TODO: implement initState
    _billerInfor();
    print(widget.user_id);
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
    return loading ? Loading(title:'verifying meter number..') : Scaffold(
      drawer: MyDrawer(),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
               NormalCurveContainer(
                 pagetitle: 'Buy '+ widget.unitType + ' units',
                 size: size, height: size.height* 0.44,container_radius: 120,
                 widget: Padding(
                   padding: const EdgeInsets.only(left:18.0,right: 18),
                   child: atmCard(size,amount,widget.username),
                 ),),
                                   Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 10.0, top: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [    
                             selectbillerWidget(),                                                              
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
                                  MyTextField(
                                    // validator:  MultiValidator(
                                    //       [
                                    //         RequiredValidator(errorText: 'Required'),
                                    //         MinLengthValidator(8, errorText: 'meter number must be 11 digits long'),
                                    //       ]
                                    //     ),
                                  autovalidate: true,
                                   keyboardType: TextInputType.number,
                                  hintText: 'Meter number', 
                                  onChanged: (val) async {
                                    setState(() {
                                      meterNumber=val;
                                        });
                                          if(val.length==11){
                                          //   setState(() => loading=true);
                                          // var response=await BuyService().
                                          //     verifyCustomer(meterNumber, 
                                          //     selectbiller.substring(0,selectbiller.indexOf('(')),
                                          //      selectbilltype);
                                          //       var body= json.decode(response.body);                      
                                          //       print(response.body);
                                          //        if(body['code']=='success'){                                               
                                          //            print(body['data']);                                                     
                                          //            print(body['data']['customer_name']);
                                          //             setState(() => loading=false);
                                          //       }else{
                                          //       setState(() => loading=false);
                                          //       setState(() => error=body['message']);
                                                
                                          //       }
                                        }
                                    },                                                        
                                  ),                           
                                    SizedBox(
                                        height:15,
                                    ),
                             MyTextField(
                               hintText: '(#) Amount(not less than N1000)',
                               validator: (val)=> val!.isEmpty ? 'enter amount number' : null,
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
                        placeHolder: 'Continue', pressed: () async {
                          Energy buyenergyinfo= 
                              Energy(
                                user_id: widget.user_id,
                                username: widget.username,
                                email: widget.email,
                                   biller: selectbiller, 
                                billType: selectbilltype, 
                                amount: amount,
                                phone: phone,
                                meternumber: meterNumber
                                );
                          print('selectbiller2 '+selectbiller);
                          
                          setState(() {
                            loading=true;
                          });
                          //  MyNavigate.navigatejustpush(
                          //                           OrderSummary(buyenergyinfo:buyenergyinfo
                          //                               ), context);
                          var response=await BuyService().
                                              verifyCustomer(meterNumber, 
                                              selectbiller.substring(0,selectbiller.indexOf('(')),
                                               selectbilltype);
                                                var body= json.decode(response.body);                      
                                                print(response.body);
                                                 if(body['success']==true){                                                   
                                                     print(body['customer_name']);
                                                     buyenergyinfo.customername=body['customer_name'];
                                                     buyenergyinfo.address=body['address'];
                                                         MyNavigate.navigatejustpush(
                                                    OrderSummary(buyenergyinfo:buyenergyinfo
                                                        ), context);
                                                      setState(() => loading=false);
                                                }else{
                                                setState(() => loading=false);
                                                setState(() => error=body['error'].toString());
                                                
                                                }
                          // MyNavigate.navigatejustpush(OrderSummary(), context);
                          
                        }, 
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
                      setState(() { error='';selectbiller='';selectbilltype='';});
                     if(selectbiller=='Select biller'){
                                          //no package seleceted
                                          setState(() {
                                            billerError='Please select biller';
                                          });
                                        }else{ 
                                          setState(() {billingTypeError='';});
                                          }
                                    if(selectbilltype=='Select billing type'){
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
   Widget selectbillerWidget()=>Padding(
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
            });
          },
          items:biller
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
            );
          }).toList(),
    ),
       ),
     );
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
          value: selectbilltype,
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
             selectbilltype= newValue!;
              // print('selectbilltype'+selectbiller);
            });
          },
          items:billtype
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
   
  
// class DropDownWidget extends StatefulWidget {
  
//     String dropdownValue;
//     List<String> items;
//    DropDownWidget({
//     Key? key,
//     required this.dropdownValue,
//     required this.items,
//   }) : super(key: key);

//   @override
//   _DropDownWidgetState createState() => _DropDownWidgetState();
// }

// class _DropDownWidgetState extends State<DropDownWidget> {
//   late String dropDown=widget.dropdownValue;
//   @override
//   Widget build(BuildContext context) {
//      return Padding(
//        padding: const EdgeInsets.all(18.0).copyWith(left: 1,right: 1),
//        child: Container(
//          height: 50,
//          padding: EdgeInsets.only(left: 25,right: 25),
//          decoration: BoxDecoration(
//           //  border: Border.all(color: Colors.grey, width: 1),
//           color: myLightPurple.withOpacity(0.2),
//            borderRadius: BorderRadius.circular(12)
           
//          ),
//          child: DropdownButton<String>(
//            dropdownColor: myLightOrange,
//           value: dropDown,
//           icon: const Icon(
//             Icons.expand_more,
//             color: Colors.grey,
//             ),
//           iconSize: 24,
//           elevation: 16,
//           isExpanded: true,
//           style: const TextStyle(color: Colors.grey),
//           underline: SizedBox(),
//           onChanged: (String? newValue) {
//             setState(() {
//              dropDown= newValue!;
//              widget.dropdownValue= newValue;
//               print('newValue'+newValue);
//               print('widget.dropdownValue'+widget.dropdownValue);
//               print(dropDown);
//             });
//           },
//           items: widget.items
//               .map<DropdownMenuItem<String>>((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Text(value,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
//             );
//           }).toList(),
//     ),
//        ),
//      );
//    }
// }
 Widget atmCard(size,amount,name)=>Container(                 
                              height: size.height * 0.27,
                              decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(30)),                
                              boxShadow: [
                                            BoxShadow(
                                              color: Colors.white.withOpacity(0.6),
                                              spreadRadius: 2,
                                              blurRadius: 10,
                                              offset: Offset(0, 5), // changes position of shadow
                                            ),
                                          ],
                              gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: mypurpleGradient
                                    )
                              ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                 Padding(
                                   padding: const EdgeInsets.only(left: 10,right: 10),
                                   child: Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     children: [
                                          
                                       Column(
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                           Text('Total',
                                        style: TextStyle(color: Colors.white, fontSize: 15),
                                      ),
                                           GradientText('N $amount',
                                           gradient: LinearGradient(colors: myOrangeGradient),
                                            style: TextStyle(color: Colors.white, 
                                            fontWeight: FontWeight.bold, fontSize: 25),
                                            ),
                                         ],
                                       ),
                                            Container(
                                        padding: EdgeInsets.all(0.0),
                                        height: 60,
                                        child:
                                          Image.asset('assets/atmchip.png')
                                    ),
                                      
                                     ],
                                   ),
                                 ),

                                Padding(
                                  padding: const EdgeInsets.only(left: 10,right: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [                                                                    
                                    Text('**** **** *** 1112',
                                      style: TextStyle(color: Colors.white, fontSize: 20),
                                    ),
                                    SizedBox(height: 5,),
                                          Text(name,
                                            style: TextStyle(color: Colors.white, 
                                            fontWeight: FontWeight.bold, fontSize: 15),
                                          ),
                                        ],
                                      ),
                                         Container(
                                        padding: EdgeInsets.all(0.0),
                                        height: 60,
                                        child:
                                          Image.asset('assets/mastercard.png')
                                    ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                   );