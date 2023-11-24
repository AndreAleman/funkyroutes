import 'package:flutter/material.dart';

class ListSquare extends StatelessWidget {
 final String house;

 ListSquare({required this.house});

 @override
 Widget build(BuildContext context) {
   return ListTile(
     title: Text(house),
   );
 }
}