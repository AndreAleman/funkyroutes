import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:funky_routes/database/user_info.dart';
import 'package:funky_routes/location/location.dart';
import 'package:funky_routes/routes.dart';
import 'package:funky_routes/List/list_screen.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); // Initialize Firebase

  final userData = await getUserData('1'); // Get user data
  final houses = userData['houses']; // Get the list of houses from the user data

  print('List of Houses:'); // Print a message
  houses.forEach((house) {
    print(house); // Print each house in the list
  });

  sendData();
  runApp(MyApp()); // Run the app
  //requestLocationPermission(); // Request location permission
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: appRoutes, // Set the app routes
    );
  }
}


//http://127.0.0.1:5000
