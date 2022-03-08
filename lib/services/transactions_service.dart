  
  
import 'dart:convert';
import 'package:buyenergy/buynits/models/transaction_list_model.dart';
import 'package:buyenergy/buynits/models/transactions_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

import 'database_service.dart';

  class TransactionService{
    
          // static final BuyService buyInstance= BuyService._init();
          // BuyService._init(

          // );
        static final TransactionService transactionInstance= 
                                        TransactionService._init();
        TransactionService._init();

        final String _url='http://192.168.43.193:8000/api/';
       

       getBalance() async{
            var response=await DataBaseService().getData('getBalance');
            var body= json.decode(response.body);
            print(response.body);
            return response;
        }
    //  Future<List<TransactionsModel>>  
     Future<TransactionsModel> getUserTransactions(user_id) async{
        var data={
            'user_id':user_id,
            };

            var response=await DataBaseService().postData(data, 'getUserTransactions');
            //var datar=jsonDecode(response);
            var responseData = json.decode(response.body);
            print(responseData);
            var amount= responseData['total_amount'];
            var units = responseData['total_units'];
            var total_trx = responseData['total_transactions'];
            var trx_list = responseData['transactions'];
         
            //var transactionList  = TransactionListModel(user_id: user_id)

            

            var trxModel = TransactionsModel(total_amount: amount, 
             total_units: units, total_transactions: total_trx, transactions: trx_list);

            
        print(trxModel.total_amount);
        return trxModel;
   }
   Future<TransactionsModel> getUserEnergyUsage(user_id) async{
        var data={
            'user_id':user_id,
            };

            var response=await DataBaseService().postData(data, 'getUserEnergyUsage');
            //var datar=jsonDecode(response);
            var responseData = json.decode(response.body);

            var amount= responseData['total_amount'];
            var units = responseData['total_units'];
            var total_trx = responseData['total_transactions'];
            var trx_list = responseData['transactions']; 

            var trxModel = TransactionsModel(total_amount: amount, 
             total_units: units, total_transactions: total_trx, transactions: trx_list);
             print(trxModel.total_transactions);
             return trxModel;
   }

  }

  //  for (var singleUser in responseData) {
  //              TransactionsModel transaction= TransactionsModel(
  //                total_amount: singleUser['total_amount'],
  //                 total_units:singleUser['total_units'],
  //                 total_transactions: singleUser['total_transactions'],
  //                 transactions: singleUser['transactions']
  //                 );
  //                  //Adding user to the list.
  //                 transactions.add(transaction);
  //            }
  //            print(transactions);