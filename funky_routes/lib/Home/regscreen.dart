
import 'package:flutter/material.dart';
import 'package:funky_routes/List/list_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'auth_viewmodel.dart';
import 'reg_viewmodel.dart';


class RegScreen extends StatefulWidget{
  const RegScreen({super.key});

  @override
   State<RegScreen> createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen>{
final _formKey = GlobalKey<FormState>();
 final TextEditingController _emailController = TextEditingController();
 final TextEditingController _passwordController = TextEditingController();
final TextEditingController _passwordConfirmController = TextEditingController();
 final TextEditingController _nameController = TextEditingController();
 final TextEditingController _streetController = TextEditingController();
 final TextEditingController _cityController = TextEditingController();
 final TextEditingController _stateController = TextEditingController();
 
 final RegViewModel _regViewModel = RegViewModel();


  TextFormField _buildTextField(TextEditingController controller, String hintText, String errorMessage) {
    return TextFormField(
      controller: controller,
      validator:(value){
        if(value == null || value.isEmpty){
          return 'Please enter $errorMessage';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
    }






  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text ('Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(_emailController, 'Email', 'email'),
              _buildTextField(_passwordController, 'Password', 'password'),
              _buildTextField(_passwordConfirmController, 'Confirm Password', 'matching password'),
              _buildTextField(_nameController, 'Name', 'name'),
              const Text(
                'Please enter ......',
                style: TextStyle(fontSize: 16),
              ),
              _buildTextField(_streetController, 'Street', 'street'),
              _buildTextField(_cityController, 'City', 'city'),
              _buildTextField(_stateController, 'State', 'state'),
              ElevatedButton(
              onPressed: () {
                if(_passwordController.text != _passwordConfirmController.text){
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Error'),
                          content: Text('Your passwords do not match'),
                          actions: <Widget>[
                            TextButton(
                              child: Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                }
                else{
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ListScreen(listTitle: 'title')),
                  );
                }
              },
              child: const Text('Login'),
              ),

            ],
          ),
        ),
      ),
   );
  }
}







// //email text field
//               TextFormField(
//                 controller: _emailController,
//                 validator:(value){
//                   if(value == null || value.isEmpty){
//                     return 'enter your email already';
//                   }
//                   return null;
//                 },
//                 decoration: const InputDecoration(
//                   hintText: 'Email',
//                 ),
//               ),
// //password text field
//               TextFormField(
//                 controller: _passwordController,
//                 validator:(value){
//                   if(value == null || value.isEmpty){
//                     return 'enter your password already';
//                   }
//                   return null;
//                 },
//                 decoration: const InputDecoration(
//                   hintText: 'Password',
//                 ),
//               ),
// //password confirmation text field              
//               TextFormField(
//                 controller: _passwordConfirmController,
//                 validator:(value){
//                   if(value == null || value.isEmpty){
//                     return 'enter your password confirmation already';
//                   }
//                   else if(value != _passwordController.text){
//                     return 'your passwords do not match';
//                   }
//                   return null;
//                 },
//                 decoration: const InputDecoration(
//                   hintText: 'Confirm Password',
//                 ),
//               ),
// //name text field
//               TextFormField(
//                 controller: _nameController,
//                 validator:(value){
//                   if(value == null || value.isEmpty){
//                     return 'enter your name already';
//                   }
//                   return null;
//                 },
//                 decoration: const InputDecoration(
//                   hintText: 'Name',
//                 ),
//               ),

// //street text field

//               TextFormField(
//                 controller: _streetController,
//                 validator:(value){
//                   if(value == null || value.isEmpty){
//                     return 'enter your street already';
//                   }
//                   return null;
//                 },
//                 decoration: const InputDecoration(
//                   hintText: 'Street',
//                 ),
//               ),
// //city field
//               TextFormField(
//                 controller: _cityController,
//                 validator:(value){
//                   if(value == null || value.isEmpty){
//                     return 'enter your city already';
//                   }
//                   return null;
//                 },
//                 decoration: const InputDecoration(
//                   hintText: 'City',
//                 ),
//               ),
//               //name text field
//               TextFormField(
//                 controller: _cityController,
//                 validator:(value){
//                   if(value == null || value.isEmpty){
//                     return 'enter your name already';
//                   }
//                   return null;
//                 },
//                 decoration: const InputDecoration(
//                   hintText: 'Name',
//                 ),
//               )