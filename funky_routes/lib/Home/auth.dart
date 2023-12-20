import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';

class Auth {
 final FirebaseAuth _auth = FirebaseAuth.instance;

 Future<void> registerWithEmailAndPassword(String email, password) async {
   try {
     final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
       email: email,
       password: password,
     );

     CollectionReference users = FirebaseFirestore.instance.collection('Users');
     return users
       .add({
         'Email': email,
         'Home' : ''
       })
     .then((value) => print("User Added"))
     .catchError((error) => print("Failed to add user: $error"));
     
   } on FirebaseAuthException catch (e) {
     if (e.code == 'weak-password') {
       print('The password provided is too weak.');
     } else if (e.code == 'email-already-in-use') {
       print('The account already exists for that email.');
       signInWithEmailAndPassword(email, password);
     }
   } catch (e) {
     print(e);
   }
 }

 Future<void> signInWithEmailAndPassword(String email, String password) async {
   try {
     final userCredential = await _auth.signInWithEmailAndPassword(
       email: email,
       password: password,
     );
     print('User signed in: ${userCredential.user?.uid}');
   } on FirebaseAuthException catch (e) {
     if (e.code == 'user-not-found') {
       print('No user found for that email.');
     } else if (e.code == 'wrong-password' || e.code == 'invalid-credential') {
       print('Wrong password provided for that user.');
       throw Exception('Wrong password provided for that user');
     }
   } catch (e) {
     print(e);
   }
 }


 Future<void> signOut() async {
  await _auth.signOut();
 // _isLogin = false; // Set _isLogin to false when the user signs out
 }


}
