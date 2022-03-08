
import 'dart:io';

class Energy{
  final  user_id;
  final String username;
  final String email;
  String? customername;
  String? address;
  final String biller;
  final String billType;
  final String amount;
  final String? phone;
  final String? meternumber;
  
  final String? created_time;

  Energy({
        required this.user_id,
        required this.username,
        required this.email,
         this.customername,
         this.address,
        this.phone,
        required this.biller, 
        required this.billType, 
        required this.amount, 
        this.meternumber, 
         this.created_time});
   
   static Energy fromJson(Map<String, dynamic> json) => Energy(
        user_id: json['user_id'],
        username: json['username'],
        email: json['email'],
        billType: json['billType'] ,
        biller: json['biller'],
        phone :json['phone'],
        amount: json['amount'] ,
        created_time: DateTime.parse(json['created'] as String) as String,
      );
      
       Map<String, dynamic> toJson()=>{
              'username' :username,
             'billType': billType,
             'biller': biller,
             'phone': phone,
             'meternumber': meternumber,
             'amount': amount,
             'created_time': DateTime.now().toString(),
            // 'TimeStamp':DateTime.now(),
     };
}