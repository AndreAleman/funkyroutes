import 'package:flutter/material.dart';

class ListSquare extends StatelessWidget{


  @override 
  Widget build(BuildContext context){
    return 
      Padding(
      padding: const EdgeInsets.all(8.0),
      child: 
          Container(
            height: 200,
            color: Colors.purple[200],
          ),
    );  
  }
}