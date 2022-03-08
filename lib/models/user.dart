


class User{
  // final String role;
  
  final String id;
  final String name;
  final String email;
  final String phone;
  final String address;

  User( {
    required this.id,
    required this.name,
    required this.email,
    required this.address,
    required this.phone,
     
  });
  static User fromJson(Map<String,dynamic> json)=>User(
    id: json['id'], 
    name: json['name'], 
    email: json['email'],
     address: json['address'],
      phone: json['phone']
  );
}

