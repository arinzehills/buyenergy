
import 'dart:io';

class TransactionListModel{
   final int user_id;
   final String? order_id;
   final String? product_name;
   final String? transaction_type;
   final String? purchased_token;
   final int? phone;
   final String? units;
   final int? amount;
   final String? created_at;
  
  // final String? created_time;

  const TransactionListModel({
        required this.user_id,
        this.order_id,
        this.product_name,
        this.transaction_type,
        this.purchased_token,
        this.phone,
        this.units,
        this.amount,
        this.created_at,

       // required this.total_amount,
      //  required this.total_units,
      //   this.total_transactions,
        // this.transactions=const [],
        //  this.created_time
         
         });
   
  static TransactionListModel fromJson(Map<String, dynamic> json) => TransactionListModel(
       user_id: json['total_amount'],
       order_id: json['order_id'],
      //  total_transactions: json['total_transactions'],
      //   transactions: json['transactions'],
      //   created_time: DateTime.parse(json['created_at'] as String) as String,
     );
      
    //    Map<String, dynamic> toJson()=>{
    //           'total_amount' :total_amount,
    //          'billType': billType,
    //          'biller': biller,
    //          'phone': phone,
    //          'meternumber': meternumber,
    //          'amount': amount,
    //          'created_time': DateTime.now().toString(),
    //         // 'TimeStamp':DateTime.now(),
    //  };
}