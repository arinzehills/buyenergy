
import 'dart:convert';

import 'package:buyenergy/authentication/login.dart';
import 'package:buyenergy/components/gradient_text.dart';
import 'package:buyenergy/components/my_gradient_button.dart';
import 'package:buyenergy/components/my_text_field.dart';
import 'package:buyenergy/components/no_account.dart';
import 'package:buyenergy/constants/constants.dart';
import 'package:buyenergy/constants/loading.dart';
import 'package:buyenergy/constants/my_navigate.dart';
import 'package:buyenergy/dashboard.dart';
import 'package:buyenergy/getstarted_page.dart';
import 'package:buyenergy/services/database_service.dart';
import 'package:flutter/material.dart';

import '../home_page_navigation.dart';

class Register extends StatefulWidget {
  Register({Key? key, }) : super(key: key);


  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final _formKey = GlobalKey<FormState>();
    bool obscureText=false;
    String name='';
  String email='';
  String phone='';

    bool loading=false;

  String password='';

  String confirmPassword='';
  bool autovalidate=false;
  String error='';
       Future <bool> _onBackPressed(){
    
    return Navigator.of(context).push(
                     MaterialPageRoute(builder: (context) => GetStartedPage()),
                     ).then((value) => value);
  }
  @override
  Widget build(BuildContext context){
    Size size= MediaQuery.of(context).size;
          return loading ? Loading() : WillPopScope(
             onWillPop: ()=>_onBackPressed(),
            child: Scaffold(
            body: SafeArea(
                child: SingleChildScrollView(
              child: Stack(
               
                children:[ 
                   Positioned(
                  top: -90,
                  right: -19,
                  child: Image.asset(
            'assets/mycurve.png',
            width:size.height * 0.805,
            height:400,
            ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  
                  children: [
            
            Padding(
              padding: const EdgeInsets.only(top:139.0),
              child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Container(
                      padding: EdgeInsets.all(0.0),
                      height: 50,
                       child:
                        Image.asset('assets/logo_transparent.png')
                  ),
                  GradientText(
                    'REGISTER',
                    style: const TextStyle(
                      fontSize: 35
                      ),
                    gradient: LinearGradient(
                       begin: Alignment.centerRight,
                      end: Alignment.bottomRight,
                      colors:myOrangeGradient),
                    
                  ),
                                 
                   
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 10.0, top: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                            'Full name',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                            
                                  SizedBox(
                                      height:10,
                                  ),
                          MyTextField(hintText: 'Enter your full name',
                             keyboardType: TextInputType.name,
                                autovalidate: false,
                                validator: (val)=> val!.isEmpty ? 'Please Enter a Name' : null,
                                onChanged:  (val){
                                              if(mounted) {setState(() =>name=val);}
                                          },
                                ),
                                  SizedBox(
                                      height:20,
                                  ),
                           Text(
                            'Email',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                                  SizedBox(
                                      height:10,
                                  ),
                           MyTextField(
                             keyboardType: TextInputType.emailAddress,
                            //  validator: MultiValidator(
                            //                 [
                            //                   RequiredValidator(errorText: 'Required'),
                            //                   EmailValidator(errorText: "Enter a Valid Email")
                            //                 ]
                            //               ),
                              autovalidate: autovalidate,
                               onChanged:  (val){
                                              if(mounted) {setState(() =>email=val);}
                                          },
                                  onTap: (){
                                          if(autovalidate==true){
                                                      setState(() {
                                                        autovalidate=false;
                                                      });
                                                    }
                                                    else{
                                                      setState(() {
                                                         autovalidate=true;   
                                                      });
                                                    }
                             },
                             hintText: 'Enter your email',
                             value: email,
                             ),
                           
                                  SizedBox(
                                      height:20,
                                  ),
                           Text(
                            'Password',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                           MyTextField(
                             hintText: 'Enter password',
                             keyboardType: TextInputType.visiblePassword,
                            //  validator:MultiValidator(
                            //             [
                            //               RequiredValidator(errorText: 'Required'),
                            //                 MinLengthValidator(6, errorText: 'Password must be at least 6 character long'),
                            //             ]
                            //           ),
                                autovalidate: autovalidate,
                                 onChanged:  (val){
                                             if(mounted) {setState(() =>password=val);
                                             }
                                          },
                                  onTap: (){
                               if(autovalidate==true){
                                                      setState(() {
                                                        autovalidate=false;
                                                      });
                                                    }
                                                    else{
                                                      setState(() {
                                                  autovalidate=true;   
                                                    });
                                                    }
                             },
                             obscureText:obscureText,
                             value: password,
                             suffixIconButton: IconButton(
                                                  icon: const Icon(Icons.visibility),
                                                  color:myPurple,
                                                  onPressed: () {
                                                   if(obscureText==true){
                                                      setState(() {
                                                        obscureText=false;
                                                      });
                                                    }
                                                    else{
                                                      setState(() {
                                                  obscureText=true;   
                                                    });
                                                    }
                                                  },
                                                ),
                                              ),
                            SizedBox(
                                      height:20,
                                  ),
                                  Text(
                                          error ,
                                          style: TextStyle(color: Colors.red),
                                          ),  
                                           SizedBox(
                                      height:10,
                                  ),
                          MyGradientButton(
                      placeHolder: 'Register Now',                  
                      // secondcolor:const Color(0xff0b6dff),
                      firstcolor:  myLightPurple,
                     secondcolor: myPurple   ,
                      // firstcolor:const Color(0xff0bc9ff) ,
                      pressed: () async {
                      // if(_formKey.currentState!.validate()){
                       
                            
                      // }
                      setState(() => loading=true);
                      var response=await DataBaseService().register(name, email, password);
                     var body= json.decode(response.body);                      
                      print(response.body);
                          if(body['success']==true){
                          snackBar(Login(), context,'Registered! Login in');
                      MyNavigate.navigatejustpush(Login(), context);
                        }else{
                        setState(() => loading=false);
                        print(error=body['email'][0]);
                        setState(() => error=body['email'][0]);
                        
                        }
                      },
                      ),
                      SizedBox(height: 15,),
                       NoAccount(
                title: 'Already have an account?',
                subtitle: 'LOGIN',
                pressed: (){
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                                    Login()), (Route<dynamic> route) => false);
                },
                        )  
                  ],
                ),
              ),
            ),
            
                  ],
                ),
                ]
              ),
            )),
          ),
          );
  }
}