
  import 'package:buyenergy/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'components/gradient_text.dart';

class Constants{
  Constants._();
  static const double padding =20;
  static const double avatarRadius =45;
}
  
   class Contact{
     final String title;
     final String imgurl;     
    String launchurl;
     Contact({required this.title, required this.imgurl,required this.launchurl});
   }
class ContactUs extends StatefulWidget {
  
  String title;
  Image? image;
   ContactUs({
     this.image,required this.title,
   });
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
    @override
    void initState(){
      super.initState();
    }
    List<Contact> contacts=[
      
        Contact(title: 'Call', imgurl: 'call.png',launchurl: "tel:08934433443"),
        Contact(title: 'Email', imgurl: 'email.png',launchurl: "mailto:08934433443"),
        Contact(title: 'Whatsapp', imgurl: 'whatsapp1.png',
        launchurl: "http:wa.me/message/NXZFVXWM6KQRL1"),
    ];
    Widget _buildList(){
                
            return ListView.separated(
              padding: const EdgeInsets.fromLTRB(0,1,8,1),
              itemCount: contacts.length,
              itemBuilder: (BuildContext context, int index) {
              return Card(
                  child:ListTile(
                          title: Text(contacts[index].title,
                                    style: TextStyle(
                                      color: Colors.amber,
                                      fontWeight: FontWeight.bold,
                                      ),
                                    ),
                          subtitle: Padding(
                            padding: EdgeInsets.all(3.0),
                            
                          ),
                          contentPadding: EdgeInsets.fromLTRB(-7,5,3, 5),
                          leading:  CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: Constants.avatarRadius,
                          child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(Constants.avatarRadius)),
                          child: Image.asset("assets/"+ contacts[index].imgurl, height: 41,)
                                        ),
                                     ),
                          onTap:() => {  
                              launch(contacts[index].launchurl)
                          }),
                        );
                  },
            separatorBuilder: (BuildContext context, int index) => const Divider(height: 1,),
                );
             } 
          
           
         
        
    
    //used for place order class
      contentBox(context, list){
      return Stack(
         children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: Constants.padding,top: Constants.avatarRadius
            , right: Constants.padding,bottom: Constants.padding
          ),
          margin: EdgeInsets.only(top: Constants.avatarRadius),
          width: double.infinity,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(Constants.padding),
            boxShadow: [
              BoxShadow(color: Colors.black,offset: Offset(0,10),
              blurRadius: 50
              ),
            ]
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              GradientText(
                widget.title,
                gradient: LinearGradient(colors: myOrangeGradient),
                style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600,
                  wordSpacing: 3),
                ),
              SizedBox(height: 4,),
              Divider(),Spacer(
               
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left:1,top: 95
            , right: 1,bottom: 1
          ),
            margin: EdgeInsets.only(top: Constants.avatarRadius),
            
         child: list
        ),
        Positioned(
          left: Constants.padding,
            right: Constants.padding,
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: Constants.avatarRadius,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(Constants.avatarRadius)),
                  child: Image.asset("assets/launchericon.png",
                  )
              ),
            ),
        ),
      ],
      );
    }
    
  @override
  Widget build(BuildContext context) {
    return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60),
           ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: contentBox(context,_buildList()),          
      );
  }
}
  