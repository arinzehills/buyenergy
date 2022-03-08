
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

class Wrapper extends StatelessWidget {
  Wrapper({ Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    
     final user= Provider.of<User>(context);

    return Container(
      
    );
  }
}