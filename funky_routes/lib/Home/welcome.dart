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
      child: Text(
        'Welcome',
        style: TextStyle(fontSize: 30),
      ),
    ),
  );
 }
}

