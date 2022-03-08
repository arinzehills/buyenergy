import 'dart:convert';

import 'package:buyenergy/components/my_button.dart';
import 'package:buyenergy/components/my_gradient_button.dart';
import 'package:buyenergy/constants/constants.dart';
import 'package:buyenergy/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:form_field_validator/form_field_validator.dart';

 class Constants{
  Constants._();
  static const double padding =20;
  static const double avatarRadius =45;
}
class BottomModal extends StatefulWidget {
    String title;
    String titletype;
   BottomModal({ Key? key, required this.title,required this.titletype}) : super(key: key);

  @override
  _BottomModalState createState() => _BottomModalState();
}

class _BottomModalState extends State<BottomModal> {
    final _formKey = GlobalKey<FormState>();
    String title='';
    String error='';
      bool loading=false;

    var userToken;
    @override
   void initState() {
    _getUserInfo();
    super.initState();
    // var index = widget.index;
  }
void _getUserInfo() async{
                      SharedPreferences localStorage= await SharedPreferences.getInstance();

                      var token=localStorage.getString('token');
                      print(token);
                      // var token=json.decode(tokenJson!);
                      setState(() {
                        userToken=token;
                      });
}
  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.only(top:299.0),
          child: Card(
            color: Colors.transparent,
            child: Container(
                padding: EdgeInsets.only(left:1,top:30, right:1,bottom:20),
                margin: EdgeInsets.only(top: Constants.avatarRadius * 0.1),
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
                          'Edit',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,                                                      
                                fontFamily: 'Roboto'
                                ),
                                
                                ),
                      ),
                      
                      SizedBox(height: 4,),                                 
                          SingleChildScrollView(
                            child: Form(
                                    key: _formKey,
                                    child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 12.0, right: 12),
                                                  child: TextFormField(
                                                  validator:MultiValidator(
                          
                                                              [
                                                                //  EmailValidator(errorText: 'Please enter a valid email'),
                                                                RequiredValidator( errorText: 'Please space cannot be empty'),
                                                              ]
                                                            ),
                                                      decoration:textFieldDecoration.copyWith(                                                                  
                                                      hintText:widget.title ,
                                                                        ) ,
                                                      onChanged: (val) => {title=val},
                                                          ),
                                                ),
                                                      SizedBox(height: 20,),
                                                Center(
                                                  child: MyGradientButton(
                                                    placeHolder: 'Update', 
                                                    pressed: () async {
                                                        if(_formKey.currentState!.validate()){
                                                         setState(() => loading=true);

                                                              setState(() {
                                                        widget.title=title;
                                                      });
                                                          var datatoupdate={
                                                            widget.titletype:widget.title
                                                          };
                                                          var response=await DataBaseService()
                                                                              .update(datatoupdate,userToken);
                                                          var body= json.decode(response.body);                      
                                                            print(response.body);
                                                            if(body['success']==true){
                                                            // snackBar(HomePageNavagation(), context, 'Logged in successfully');
                                                            Navigator.pop(context);
                                                            SharedPreferences localStorage= await SharedPreferences.getInstance();
                                                            // localStorage.setString('token', body['token']);
                                                            localStorage.setString('user', json.encode(body['user']));
                                                            print(body['token']);
                                                            }else{
                                                            // setState(() => loading=false);
                                                            setState(() => error=body['message']);
        
        }
                                                                  }
                                                          
                                                        }, 
                                                        firstcolor: myLightOrange,
                                                        secondcolor: myOrange
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
}