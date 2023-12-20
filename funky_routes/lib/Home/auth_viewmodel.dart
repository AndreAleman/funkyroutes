import 'package:email_validator/email_validator.dart';
import 'auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';

class AuthViewModel{
 final Auth _auth = Auth();

 Future<String> handleSubmit(String email, String password, BuildContext context) async {
 try{
   await _auth.signInWithEmailAndPassword(email, password);
   return 'From Login';
 } on FirebaseAuthException catch (e){
   if(e.code == 'user-not-found'){
     try{
       await _auth.registerWithEmailAndPassword(email, password);
       return 'From Login but registered';
         // Show a dialog or a snackbar with the error message
         
       } on FirebaseAuthException catch (e){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message ?? 'An emessage error ocurred')));
        throw e;
       }
     }
   } catch (e) {
     // Show a dialog or a snackbar with the error message
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
     throw e;
   }
   return 'Unknown';
 }
}