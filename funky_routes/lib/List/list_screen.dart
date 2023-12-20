
import 'package:flutter/material.dart';
import 'package:funky_routes/List/list_themes.dart';
import 'package:funky_routes/main.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:funky_routes/Home/welcome.dart';
import 'package:funky_routes/database/user_info.dart';
import 'package:funky_routes/location/location.dart';
import 'package:funky_routes/routes.dart';
import 'package:funky_routes/List/list_screen.dart';
import 'package:funky_routes/Home/authscreen.dart';
import 'package:funky_routes/Home/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';



class ListScreen extends StatelessWidget{
  final String url = 'http://10.0.2.2:5000/get_houses';
  final String listTitle;
  ListScreen({Key? key, required this.listTitle}) : super(key: key);

  FirebaseAuth auth = FirebaseAuth.instance;

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
   appBar: AppBar(
     title: Text(listTitle),
     actions: <Widget>[
       IconButton(
         icon: Icon(Icons.exit_to_app), // Use an appropriate icon
         onPressed: () {
         auth.signOut();
         Navigator.pushNamed(context, '/welcomescreen');
           // Use this to Log Out user
           
         },
       ),
     ],
   ),
   body: Padding(
     padding: const EdgeInsets.all(16.0),
     child: FutureBuilder<List<String>>(
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
   ),
 );
}
}