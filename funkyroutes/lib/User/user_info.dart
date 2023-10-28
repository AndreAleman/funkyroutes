import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;


Future<Map<String, dynamic>> getUserData(String userId) async {
  final userDoc = await FirebaseFirestore.instance.collection('Users').doc(userId).get();
  final housesSnap = await FirebaseFirestore.instance.collection('Users').doc(userId).collection('Houses').get();

  final home = userDoc.data()?['home'];
  final houses = housesSnap.docs.map((doc) => doc.data()['Address']).toList();

  return {'home': home, 'houses': houses};
}

void sendData() async {
  String url = 'http://127.0.0.1:5000/receive_user_data'; // Replace with your Flask API URL
  Map<String, dynamic> userData = await getUserData('1'); // Replace '1' with the actual user ID

  http.Response response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'username': '1', // Replace '1' with the actual user ID
      'addresses': userData['houses'], // Send the list of houses as the addresses
    }),
  );
}