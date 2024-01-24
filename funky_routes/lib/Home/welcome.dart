import 'package:flutter/material.dart';
import 'auth.dart';

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

 class CustomSpacer extends StatelessWidget {
   @override
   Widget build(BuildContext context) {
     return SizedBox(height: 10);
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
        const Text(
           'Welcome',
           style: TextStyle(fontSize: 30),
         ),
         CustomSpacer(),
         ElevatedButton(
           onPressed: (){
             // Navigate to the login screen
             Navigator.pushNamed(context, '/regscreen');
           },
           child: const Text('Register'),
         ), // Add some space between the text and the buttons
         CustomSpacer(),
         ElevatedButton(
           onPressed: (){
             // Navigate to the login screen
             Navigator.pushNamed(context, '/authscreen');
           },
           child: const Text('Continue with Email'),
         ),
         CustomSpacer(), // Add some space between the buttons
         ElevatedButton(
           onPressed: (){
             // Navigate to the register screen
             Navigator.pushNamed(context, '/registrationscreen');
           },
           child: const Text('Continue with Apple'),
         ),
        CustomSpacer(),
        ElevatedButton(
           onPressed: (){
            Auth().signInWithGoogle();
             // Navigate to the register screen
             Navigator.pushNamed(context, '/registrationscreen');
           },
           child: const Text('Continue with Google'),
         ),
       ],
     ),
   ),
 );
 }
}

