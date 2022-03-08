import 'dart:convert';

import 'package:buyenergy/components/drawer.dart';
import 'package:buyenergy/components/my_gradient_button.dart';
import 'package:buyenergy/components/myoval_gradient_button.dart';
import 'package:buyenergy/components/normal_curve_container.dart';
import 'package:buyenergy/constants/constants.dart';
import 'package:buyenergy/constants/loading.dart';
import 'package:buyenergy/constants/my_navigate.dart';
import 'package:buyenergy/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/profile_list.dart';
import 'edit_profile.dart';
import 'login.dart';
class Profile extends StatefulWidget {
  const Profile({ Key? key }) : super(key: key);

  
  @override
  _ProfileState createState() => _ProfileState();
}
class UserWidget{
  String title;
  String? titleType;
  IconData? leading;
  UserWidget({required this.title, this.titleType,
             this.leading});

}
class _ProfileState extends State<Profile> {
  var userData;
  var userToken;
    bool loading=false;


@override
   void initState() {
    _getUserInfo();
    super.initState();
    // var index = widget.index;
  }
void _getUserInfo() async{
                      SharedPreferences localStorage= await SharedPreferences.getInstance();

                      var userJson=localStorage.getString('user');
                      var token=localStorage.getString('token');
                      setState(() {
                        userToken=token;
                      });
                      print(userJson);
                      var user=json.decode(userJson.toString());
                      setState(() {
                        userData=user;
                      });
}
  @override
  Widget build(BuildContext context) {
     Size size= MediaQuery.of(context).size;
//     final user= Provider.of<MyUser>(context);
// final AuthService _auth=AuthService();

    return userData==null? Loading():  StreamBuilder(
      stream:null,
      builder: (context, snapshot) {
             List<UserWidget> title =[
            UserWidget(title:userData['name'] ?? 'Your name',leading: Icons.person),
            UserWidget(title:userData['phone'] ?? 'no phone no added',leading: Icons.mobile_friendly),
            UserWidget(title:userData['email'] ?? 'Your email',leading: Icons.email_outlined),
            UserWidget(title:userData['address'] ?? 'no address',leading: Icons.location_on),
          ];
        return Scaffold(
          drawer: MyDrawer(),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Stack(
                children: [                  
                  Builder(
                  builder:(context)=> Column(
                    children: [
                      NormalCurveContainer(
                        size: size,
                        height: size.height * 0.24,
                        pagetitle: 'Profile',
                        widget: Padding(
                          padding: const EdgeInsets.only(top:18.0),
                          child: Center(child: Text(userData['name'],
                          style: TextStyle(color: Colors.white, fontSize: 30),),),
                        ),
                        ),
                           Padding(
                             padding: const EdgeInsets.only(top:28.0),
                             child: ListView.separated(
                                itemCount: title.length,
                                shrinkWrap: true,
                                padding: EdgeInsets.only(top: 16),
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index){
                                  //  DocumentSnapshot  document=snapshot.data as DocumentSnapshot<Object?>;
                                  //    dynamic orderData=document.data();
                                  return 
                                  // Container();
                                  ProfileList(
                                    name: title[index].title,
                                    leading: title[index].leading,
                                  );
                                },
                                 separatorBuilder: (BuildContext context, int index) => 
                                 Container(
                                     height: 2,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(50)),
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [ myLightOrange,myOrange]
                                        )
                                        ),
                              ),
                             ),
                           ),
                            Container(
                                   height: 2,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(50)),
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [ myLightOrange,myOrange]
                                      )
                                      ),
                            ),
                            SizedBox(height: 20,),
                            MyOvalGradientButton(
                              placeHolder: 'Logout', pressed: () async { 
                                   setState(() => loading=true);
                                    var response=await DataBaseService().logout(userToken);
                                  var body= json.decode(response.body);                      
                                    print(response.body);
                                        if(body['success']==true){
                                        snackBaruntil(Login(), context,body['message']);
                                    MyNavigate.navigatejustpush(Login(), context);
                                      }else{
                                      // setState(() => loading=false);
                                      // print(error=body['email'][0]);
                                      // setState(() => error=body['email'][0]);
                                      
                                      }
                                //  MyNavigate.navigatepushuntil(Login(), context);
                              }, 
                              firstcolor: myPurple, secondcolor: myLightPurple)
                    ],
                  ),
                ),
                
                 Positioned(
                    
                child: Padding(              
                  padding: EdgeInsets.only(top:  size.height * 0.18),
                            child: Center(           
                            child:    ClipRRect(
                                            borderRadius: BorderRadius.all(Radius.circular(50)),                                        
                                            child: Image.asset(
                                              "assets/user.png",
                                              height: 90,
                                              color:myLightOrange,
                                              
                                              )
                                                          ),
                        ),
                  )
                 ),
                 Positioned(
                    
                child: Padding(              
                  padding: EdgeInsets.only(
                    top:size.height*0.8),
                  child: Center(           
                  child: MyGradientButton(
                    placeHolder: 'Edit profile', 
                    pressed: (){
                      MyNavigate.navigatejustpush(
                        EditProfile(),
                         context);
                    }, 
                    firstcolor: myOrange,
                     secondcolor: myLightOrange,
                     child: 
                                               Padding(
                                                 padding: const EdgeInsets.only(left:18.0),
                                                 child: ImageIcon(
                                                  AssetImage('assets/edit_user.png'),
                                                    size: 30,
                                                    color: Colors.white,
                                                  ),
                                               ),
                     )
              ),
                )
                 )
                ]
              ),
            ),
          ),
          );
        }
        // else{
        //   return Loading();
        // }
      
    );

  }
  
}