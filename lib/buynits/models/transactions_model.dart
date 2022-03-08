
import 'dart:io';

import 'package:buyenergy/buynits/models/transaction_list_model.dart';

class TransactionsModel{
  final num total_amount;
  final num total_units;
  final num? total_transactions;
  final List<dynamic> transactions;
   //final List<TransactionListModel> transactions;
  
  // final String? created_time;

  const TransactionsModel({
        required this.total_amount,
        required this.total_units,
         this.total_transactions,
         this.transactions=const [],
        //  this.created_time
         
         });
   
   static TransactionsModel fromJson(Map<String, dynamic> json) => TransactionsModel(
        total_amount: json['total_amount'],
        total_units: json['total_units'],
        total_transactions: json['total_transactions'],
         transactions: json['transactions'],
        // created_time: DateTime.parse(json['created_at'] as String) as String,
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