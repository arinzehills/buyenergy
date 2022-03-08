  
  
  import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

import 'database_service.dart';

  class BuyService{
    
          _setHeader()=> {
            'Content-Type':'application/json' ,
            'Accept': 'application/json'
          };


       getBalance() async{
            var response=await DataBaseService().getData('getBalance');
            var body= json.decode(response.body);
            print(response.body);
            return response;
        }
      Future<http.Response> verifyCustomer(meternumber, biller ,billType) async{
        var data={
            'billersCode':meternumber,
            'serviceID':biller,
            'type':billType,
            };

            var response=await DataBaseService().postData(data, 'verifyCustomer');
            // var body=json.decode(response.body);
            // print(body);
            print(response);
            return response;
        }
        Future<http.Response> buyElectricity(
            meter_number, biller ,billerType,
            phone ,amount,user_id,
            ) async{
            var data={
                  'billersCode':meter_number,
                  'serviceID':biller,
                  'variation_code':billerType,
                  'phone':phone,
                  'amount':amount,
                  'user_id': user_id,
              };

              var response=await DataBaseService().postData(data, 'buyElectricity');
              var body=json.decode(response.body);
              print(body);
              return response;
          }
            Future<http.Response> buyAirtime(phone, serviceID ,amount,user_id) async{
                var data={
                  'user_id': user_id,
                    'phone':phone,
                    'serviceID':serviceID,
                    'amount':amount,
                };

                var response=await DataBaseService().postData(data, 'buyAirtime');
                var body=json.decode(response.body);
                // print(body);
                return response;
            }
  }


  