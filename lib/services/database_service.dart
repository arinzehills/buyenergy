import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class DataBaseService {
    // final String _url='http://127.0.0.1:8000/api/';
    // final String liverurl='http://192.168.43.194:8000/api/';
    final liverurl='https://buyenergy.herokuapp.com/public/api/';
    postData(data,apiUrl) async{
      print('dataup'+ data.toString());
      // var fullUrl= _url+apiUrl;
      var fullUrl= liverurl+apiUrl;
      return await http.post(
        Uri.parse(fullUrl),
        body: jsonEncode(data),
        headers: _setHeader(),
      );
    }

    getData(apiUrl) async{
        //  var fullUrl= _url+apiUrl;
         var fullUrl= liverurl+apiUrl;
         return await http.get(
           Uri.parse(fullUrl),
            headers: _setHeader(),           
         );
    }
  _setHeader()=> {
    'Content-Type':'application/json' ,
    'Accept': 'application/json'
  };


  Future<http.Response> register(name, email ,password) async{
      var data={
          'name':name,
          'email':email,
          'password':password,
      };

      var response=await DataBaseService().postData(data, 'register');
      var body=json.decode(response.body);
      // print(body);
      return response;
  }
    Future<http.Response> login(email ,password) async{
      var data={
          'email':email,
          'password':password,
      };
print('datadown' );
print(data);
      var response=await DataBaseService().postData(data, 'login');
      var body= json.decode(response.body);
      // print(response.body);
      return response;
  }
    update(Map<String,String> datatoupdate,token) async{
      var data= datatoupdate;
      
        print('datadown' );
        print(data);
      var response=await DataBaseService().postData(data, 'update?token=$token');
      var body= json.decode(response.body);
      // print(response.body);
      return response;
  }
    logout(token) async{
        print('token' );
        print(token);
      var response=await DataBaseService().getData('logout?token=$token');
      var body= json.decode(response.body);
      // print(response.body);
      return response;
  }
  forgotPassword(email) async{
    var data={
          'email':email,
      };
    print(email +'email');
    var response=await DataBaseService().postData(data, 'forgotPassword');
    // var body=json.decode(response);
    // print(body);
    return response;
  }
}