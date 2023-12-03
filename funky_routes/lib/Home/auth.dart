// Import Flutter's Material Design widgets
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:funky_routes/firebase_options.dart';
import 'package:funky_routes/database/user_info.dart';
import 'package:funky_routes/location/location.dart';
import 'package:funky_routes/routes.dart';
import 'package:funky_routes/List/list_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Define a new class Auth
class Auth {
 // Initialize a FirebaseAuth instance
 final FirebaseAuth _auth = FirebaseAuth.instance;

 // Define a method to register a new user with email and password
 Future<void> registerWithEmailAndPassword(
   String email, String password) 
   async{
     // Try to register the user
     try{
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    FirebaseAuth auth = FirebaseAuth.instance;
    return users
      .add({
        'Email': email,
        'Password': password,
        'Home' : ''
      })
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));
     } on FirebaseAuthException catch(e){
       // If there's an error, check the error code
       if(e.code == 'weak-password'){
         // If the password is too weak, print an error message
         print('This password is too weak');
       } else if (e.code == 'email-already-in-use'){
           // If the email is already in use, print an error message
           print('The account already exists for that email.');
       }
     } catch(e){
       // If the error is not a FirebaseAuthException, print the error
       print(e);
     }
   }

 // Define a method to sign in an existing user with email and password
 Future<void> signInWithEmailAndPassword(String email, String password) async {
   // Try to sign in the user
   try {
       // Use FirebaseAuth to sign in the user with email and password
    //after registering the user create a collection
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    FirebaseAuth auth = FirebaseAuth.instance;
    return users
      .add({
        'Email': email,
        'Password': password,
        'Home' : ''
      })
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));

   } on FirebaseAuthException catch (e) {
       // If there's an error, check the error code
       if (e.code == 'user-not-found') {
           // If the user is not found, print an error message
           print('No user found for that email.');
       } else if (e.code == 'wrong-password') {
           // If the password is wrong, print an error message
           print('Wrong password provided for that user.');
       }
   } catch (e) {
       // If the error is not a FirebaseAuthException, print the error
       print(e);
   }
 }


}
