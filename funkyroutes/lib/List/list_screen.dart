
import 'package:flutter/material.dart';
import 'package:funkyroutes/List/list_themes.dart';



class ListScreen extends StatelessWidget{

final List<String> _houses = ['931', '1200', '1528', '88'];

  @override
  Widget build(BuildContext context){
    return Scaffold(
       body: ListView.builder(
        itemCount: _houses.length,
        itemBuilder: (context, index){
          return ListSquare();
        }
        ),
    );
  }
}