
import 'dart:convert';

import 'package:buyenergy/authentication/register.dart';
import 'package:buyenergy/components/gradient_text.dart';
import 'package:buyenergy/components/my_gradient_button.dart';
import 'package:buyenergy/components/my_text_field.dart';
import 'package:buyenergy/components/no_account.dart';
import 'package:buyenergy/constants/constants.dart';
import 'package:buyenergy/constants/loading.dart';
import 'package:buyenergy/constants/my_navigate.dart';
import 'package:buyenergy/home_page_navigation.dart';
import 'package:buyenergy/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'forgot_password.dart';

class Login extends StatefulWidget {
  Login({Key? key, }) : super(key: key);


  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final _formKey = GlobalKey<FormState>();
    bool obscureText=false;
  String email='';

  String password='';
  bool autovalidate=false;
  String error='';
      bool loading=false;
// Future <bool> _onBackPressed(){
    
//     return Navigator.of(context).push(
//                      MaterialPageRoute(builder: (context) => Login()),
//                      );
// }
  @override
  Widget build(BuildContext context){
    Size size= MediaQuery.of(context).size;
          return loading ? Loading() : Scaffold(
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
          height:410,
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
                      Image.asset('assets/camera.png')
                ),
                GradientText(
                  'Login',
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
                           hintText: 'Enter your email',
                           autovalidate: autovalidate,
                           keyboardType: TextInputType.emailAddress,
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
                            // validator: MultiValidator(
                            //               [
                            //                 RequiredValidator(errorText: 'Required'),
                            //                 EmailValidator(errorText: "Enter a Valid Email")
                            //               ]
                            //             ),                        
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
                           autovalidate: autovalidate,
                           keyboardType:TextInputType.visiblePassword,
                           onChanged:  (val){
                                            if(mounted) {setState(() =>password=val);}
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
                            // validator:MultiValidator(
                            //           [
                            //             RequiredValidator(errorText: 'Required'),
                            //               MinLengthValidator(6, errorText: 'Password must be at least 6 character long'),
                            //           ]
                            //         ),
                           suffixIconButton: IconButton(
                                                icon: const Icon(Icons.visibility),
                                                color:myLightPurple,
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
                                  forgetPassword(),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                        error,
                                        style: TextStyle(
                                          color: Colors.red,
                                          
                                          ),
                                        ),
                                              ],
                                            ), 
                        MyGradientButton(
                    placeHolder: 'Login Now',                  
                    secondcolor:myLightPurple,
                    firstcolor:myPurple,
                    pressed: () async {
                      //  snackBar(HomePageNavagation(), context, 'Logged in successfully');
                    //   // if(_formKey.currentState!.validate()){
                       
                            
                    //   // }
                      setState(() => loading=true);
                      var response=await DataBaseService().login(email, password);
                      var body= json.decode(response.body);                      
                      print(response.body);
                      if(body['success']==true){
                      snackBar(HomePageNavagation(), context, 'Logged in successfully');
                      SharedPreferences localStorage= await SharedPreferences.getInstance();
                      localStorage.setString('token', body['token']);
                      localStorage.setString('user', json.encode(body['user']));
                      print(body['token']);
                      }else{
                      setState(() => loading=false);
                      setState(() => error=body['message']);
                      
                      }
                    },
                    ),
                    SizedBox(height: 15,),
                     NoAccount(
              title: 'Already have an account?',
              subtitle: 'REGISTER',
              pressed: (){
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                                 Register() ), (Route<dynamic> route) => false);
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
);
  }
  Widget forgetPassword()=>Row(
    mainAxisAlignment: MainAxisAlignment.end,
    
    children: [
      Padding(
        padding: const EdgeInsets.only(top:18.0),
        child: GestureDetector(
                            onTap:(){
                              showDialog(context: context,
                          builder: (BuildContext context){
                            
                              return ForgotPassword();
                            });
                            },
                            child:GradientText(
                              'Forgot password?',
                              style:  TextStyle(
                                      fontSize: 15
                                      ),
                              gradient:LinearGradient(
                                    begin: Alignment.centerRight,
                                      end: Alignment.bottomRight,
                                    colors: myOrangeGradient,
                                  )
                                  )
                          ),
      ),
    ],
  );
}