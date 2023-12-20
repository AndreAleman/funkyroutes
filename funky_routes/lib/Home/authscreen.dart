import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'auth_viewmodel.dart';

class AuthScreen extends StatefulWidget{
 const AuthScreen({super.key});

 @override
 State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>{
 final _formKey = GlobalKey<FormState>();
 final TextEditingController _emailController = TextEditingController();
 final TextEditingController _passwordController = TextEditingController();
 final AuthViewModel _authViewModel = AuthViewModel();

 @override
 Widget build(BuildContext context){
   return Scaffold(
     appBar: AppBar(
       title: Text('Auth Screen'),
     ),
     body: Padding(
       padding: const EdgeInsets.all(16.0),
       child: Form(
         key: _formKey,
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             TextFormField(
               controller: _emailController,
               validator:(value) {
                if(value == null || value.isEmpty){
                  return 'enter your email already';
                }
                return null;
               },
               decoration: InputDecoration(
                hintText: 'Email',
               ),
             ),
             TextFormField(
               controller:_passwordController,
               obscureText: true,
               validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
               },
               decoration: InputDecoration(
                hintText: 'Password',
               ),
             ),
             SizedBox(height: 16.0),
            ElevatedButton(
            onPressed: () async {
              String email = _emailController.text;
              String password = _passwordController.text;
              try {
                String result = await _authViewModel.handleSubmit(email, password);
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => ListScreen(listTitle: result)));
              } catch (e) {
                // Handle the exception here, e.g. show a dialog to the user
              }
            },
            //Conditionally show the button label
            child: Text('Login'),
            ),
           ]),
       )
     ),
   );
 }
}