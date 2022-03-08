import 'dart:convert';

import 'package:buyenergy/components/my_button.dart';
import 'package:buyenergy/components/my_gradient_button.dart';
import 'package:buyenergy/constants/constants.dart';
import 'package:buyenergy/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;


 class Constants{
  Constants._();
  static const double padding =20;
  static const double avatarRadius =45;
}

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({ Key? key }) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
final _formKey = GlobalKey<FormState>();

//  _emailSuccess(context){
//     Navigator.pop(context);
//       showDialog(context: context,
//                                 builder: (BuildContext context){
                                  
//                                     return ResetPassword();
//                                   });
//     }
_emailFailure(context){
      Navigator.pop(context);
}
  String email='';
    String error='';

Future popUp(bool status){
    
    return showDialog(
      context: context,
      builder:(context)=>AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        content: Container(
          height: 170,          
          child: Center(
            child: Column(
              children: [
                     Icon(
                             status==true ? Icons.done_all_rounded : Icons.dangerous  ,
                            color: status==true ? Colors.green : Colors.red,
                            size: 93,
                          ),
                Text(
                  status==true ? 'Email Sent Successfully' : 'Please wait for some seconds before you'
                  + 'will request for another reset link  ',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Roboto'
                  ),
                ),
                SizedBox(height: 4),
                RaisedButton(
                                    child: Text(
                                      status==true ? 'OK' : 'Re-enter email',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Roboto'
                                        ),
                                      ),
                                    color: status==true ?const Color( 0xff2FCA7C) : Colors.red,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                    onPressed:()=>{
                                      status==true ? _emailFailure(context) : _emailFailure(context)
                                    },
                                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return
        Padding(
          padding: const EdgeInsets.only(top:229.0),
          child: Card(
            color: Colors.transparent,
            child: Container(
                padding: EdgeInsets.only(left:1,top:30, right:1,bottom:20),
                margin: EdgeInsets.only(top:Constants.avatarRadius * 0.1),
                decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                  color: Colors.white,                      
                borderRadius: BorderRadius.circular(Constants.padding),
                boxShadow: [
                    BoxShadow(color: Colors.black,offset: Offset(0,10),
                    blurRadius: 10
                    ),
                    ]
              ),
              child: SingleChildScrollView(
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left : 14.0),
                      child: Text(
                        'Forget Password',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,                                                      
                              fontFamily: 'Roboto'
                              ),
                              
                              ),
                    ),
                      Padding(
                      padding: const EdgeInsets.only(left : 14.0, top: 12),
                      child: Text(
                        'Please enter your email address.' +
                        'We will send you an email reset password link where you will  '+
                        'be redirected to a page to reset password',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                              ),
                        ),
                    SizedBox(height: 4,),
                    Text(error,style: TextStyle(color: Colors.red),),                               
                        SingleChildScrollView(
                          child: Form(
                                        key: _formKey,
                                        child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[                                                                 
                                              Padding(
                                                padding: EdgeInsets.only(left: 12.0,right: 35 ),
                                                  child: TextFormField(
                                                    validator:MultiValidator(
                        
                                                            [
                                                              //  EmailValidator(errorText: 'Please enter a valid email'),
                                                              RequiredValidator( errorText: 'Please input an email'),
                                                            ]
                                                          ),
                                                    decoration:textFieldDecoration.copyWith(                                                                  
                                                    hintText: 'Enter your email address',
                                                                      ) ,
                                                    onChanged: (val) => {email=val},
                                                        ),
                                              ),
                                                    SizedBox(),
                                                    Padding(
                                                      padding: EdgeInsets.only(left:8.0,top: 10),
                                                      child: MyGradientButton(
                                                placeHolder: 'Send password reset link', 
                                                pressed: () async {
                                                  if(_formKey.currentState!.validate()){
                                                      //  _forgotPassword();
                                                    print(email);
                                                    var response=await DataBaseService().forgotPassword(email);
                                                      var body= jsonDecode(response.body);      

                                                  print(body);
                                                  print(body['status']);
                                                  if(body['status']=='passwords.sent'){
                                                    popUp(true);

                                                  }else if(body['status']=='passwords.throttled'){
                                                    print('(wait)');
                                                    popUp(false);
                                                  }else{
                                                    setState(() {
                                                      error='Email address not found';
                                                    });
                                                  }
                                                    }
                                                }, 
                                                firstcolor: myOrange,
                                                secondcolor: myLightOrange,                                                               
                                                ),
                                                    )
                                          ]
                                        ), 
                                  ),
                        ) ,
                                                
                                ],
                                                                ),
                              ),
                            
                      ),
          ),
        );
  }
  _forgotPassword() async {
    print(email);

        var response=await DataBaseService().forgotPassword(email);
          var body= json.decode(response.body);                      
          print(response.body);
          if(body['success']==true){
          // snackBar(HomePageNavagation(), context, 'Logged in successfully');
          
          }else{
          // setState(() => loading=false);
          setState(() => error=body['message']);
          
          }
  }
}