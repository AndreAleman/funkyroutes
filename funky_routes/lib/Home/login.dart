import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:funky_routes/firebase_options.dart';
import 'package:funky_routes/database/user_info.dart';
import 'package:funky_routes/location/location.dart';
import 'package:funky_routes/routes.dart';
import 'package:funky_routes/List/list_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:funky_routes/Home/auth.dart';








//fetch sign in methods. check email first then go to sign in or register






class AuthScreen extends StatefulWidget{
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}


class _AuthScreenState extends State<AuthScreen>{

  final Auth _auth = Auth();
  final bool _isLogin = false;

  final _formKey = GlobalKey<FormState>();


    //Use this to store user inputs
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    handleSubmit(email, password) async {
        //Validate user inputs using formkey
        if (_formKey.currentState!.validate()) {
            //Get inputs from the controllers
          
          // final email = _emailController.value.text;
          // final password = _passwordController.value.text;
            try{
              await _auth.registerWithEmailAndPassword(email, password);

            } on FirebaseAuthException catch (e){
              if(e.code == 'user-not-found'){
              //   await _auth.registerWithEmailAndPassword(email, password);
              // } else{
               print(e);
              // }
            }
            }
        }
    }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Auth Screen'),
      ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        //add form to key to the form widget
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              //assign controller
              controller: _emailController,
              //use this function to validate user input
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
            TextFormField( //Assign controller
                controller:_passwordController,
                obscureText: true,
                //Use this function to validate user
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
              onPressed: () {
                String email = _emailController.text;
                String password = _passwordController.text;
                handleSubmit(email, password);
                //navigate to the /DriveList
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListScreen()),
                );
              },
              //Conditionally show the button label
              child: Text(_isLogin ? 'Login' : 'Register'),
            ),
          ]),
      )
    ),
    );
  }
}
 