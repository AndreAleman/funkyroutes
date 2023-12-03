import 'package:flutter/material.dart';
import 'package:funky_routes/Home/welcome.dart';
import 'package:funky_routes/List/list_screen.dart';
import 'package:funky_routes/Home/login.dart';
import 'package:firebase_auth/firebase_auth.dart';


var appRoutes = {
 '/': (context) => StreamBuilder<User?>(
   stream: FirebaseAuth.instance.authStateChanges(),
   builder: (context, snapshot) {
     if (snapshot.hasData) {
       return AuthScreen();
     } else {
       return WelcomeScreen();
     }
   },
 ),
 '/authscreen': (context) => AuthScreen(),
 '/DriveList': (context) => ListScreen()
};