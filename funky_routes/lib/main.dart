import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:funky_routes/Home/welcome.dart';
import 'firebase_options.dart';
import 'package:funky_routes/database/user_info.dart';
import 'package:funky_routes/location/location.dart';
import 'package:funky_routes/routes.dart';
import 'package:funky_routes/List/list_screen.dart';
import 'package:funky_routes/Home/authscreen.dart';
import 'package:funky_routes/Home/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); // Initialize Firebase

  final userData = await getUserData('1'); // Get user data
  final houses = userData['houses']; // Get the list of houses from the user data
  final home = userData['home'];

  print('List of Houses in main function:'); // Print a message
  houses.forEach((house) {
    print(house); // Print each house in the list
  });

  print('this is main home: $home');
  sendData(userData); // Pass the userData to the sendData function
  getHouses();

  runApp(MyApp()); // Run the app
}




class MyApp extends StatefulWidget {
 const MyApp({Key? key});

 @override
 _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
 @override
 void initState() {
  super.initState();
  FirebaseAuth.instance.signOut();
 }

 @override
 Widget build(BuildContext context) {
  return MaterialApp(
    initialRoute: '/', // Set the default route
    routes: appRoutes, // Set the app routes
    debugShowCheckedModeBanner: false,
    title: 'Flutter X Firebase',
  );
 }
}


//http://127.0.0.1:5000
