import 'package:email_validator/email_validator.dart';
import 'auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';


class RegViewModel{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> isEmailRegistered(String email) async{
    final List<String> signInMethods = await _auth.fetchSignInMethodsForEmail(email);
    return signInMethods.isNotEmpty;
  }

   
}

