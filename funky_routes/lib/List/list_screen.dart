
import 'package:flutter/material.dart';
import 'package:funky_routes/List/list_themes.dart';
import 'package:funky_routes/main.dart';
import 'package:http/http.dart' as http;



class ListScreen extends StatelessWidget{
  final String url = 'http://10.0.2.2:5000/get_houses';

  Future<List<String>> fetchRoutes() async{
    final response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      List<String> houses = response.body.split('<br>');
      houses.removeAt(0);
      return houses;
    } else{
      throw Exception('Failed to load data');
    }
  }

 @override
 Widget build(BuildContext context){
   return Scaffold(
     body: FutureBuilder<List<String>>(
       future: fetchRoutes(),
       builder: (context, snapshot) {
         if (snapshot.hasData) {
           return ListView.builder(
             itemCount: snapshot.data!.length,
             itemBuilder: (context, index){
               return ListSquare(house: snapshot.data![index]);
             }
           );
         } else if (snapshot.hasError) {
           return Text(snapshot.error.toString());
         }
         // By default show a loading spinner.
         return const CircularProgressIndicator();
       },
     ),
   );
 }
}