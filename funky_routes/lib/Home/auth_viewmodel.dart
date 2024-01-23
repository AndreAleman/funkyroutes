import 'package:email_validator/email_validator.dart';
import 'auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';

class AuthViewModel{
 final Auth _auth = Auth();



//right now becuase of the way i have it set, i am getting the error messages in the auth.dart file and then calling sign in there. it may be better to have that in the VM instead. decide if i want
//to change that tomorrow or later. all i would have to do is move the try catch statements. right now i think it's fine but it may cause problems when i change the registration
//also may change registration from email to phone number. decide that tomorrow. 
 Future<String> handleSubmit(String email, String password, BuildContext context) async {
 try{
   await _auth.signInWithEmailAndPassword(email, password);
    print('from loginnnnn');
   return 'From Login';
 } on FirebaseAuthException catch (e){
   if(e.code == 'user-not-found'){
     try{
       await _auth.registerWithEmailAndPassword(email, password);
       print('from loginnnnn but registereddddd');
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