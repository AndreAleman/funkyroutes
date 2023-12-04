import 'package:flutter/material.dart';

void main() {
 runApp(MyApp());
}

class MyApp extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
   return MaterialApp(
     home: WelcomeScreen(),
   );
 }
}

class WelcomeScreen extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Welcome Screen'),
      actions: <Widget>[
        ElevatedButton(
          onPressed: (){
            // Navigate to the login screen
            Navigator.pushNamed(context, '/authscreen');
          },
          child: Text('Login'),
        ),
      ],
    ),
 body: Center(
     child: Column(
       mainAxisAlignment: MainAxisAlignment.center,
       children: <Widget>[
         Text(
           'Welcome',
           style: TextStyle(fontSize: 30),
         ),
         SizedBox(height: 20), // Add some space between the text and the buttons
         ElevatedButton(
           onPressed: (){
             // Navigate to the login screen
             Navigator.pushNamed(context, '/authscreen');
           },
           child: Text('Login'),
         ),
         SizedBox(height: 20), // Add some space between the buttons
         ElevatedButton(
           onPressed: (){
             // Navigate to the register screen
             Navigator.pushNamed(context, '/authscreen');
           },
           child: Text('Register'),
         ),
       ],
     ),
   ),
 );
 }
}

