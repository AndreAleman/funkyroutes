// Import the necessary packages
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

// Function to get user data from Firestore
Future<Map<String, dynamic>> getUserData(String userId) async {
  // Get the user document from Firestore
  final userDoc = await FirebaseFirestore.instance.collection('Users').doc(userId).get();
  // Get the houses documents from Firestore
  final housesSnap = await FirebaseFirestore.instance.collection('Users').doc(userId).collection('Houses').get();

  // Extract the home field from the user document
  final home = userDoc.data()?['home'];
  // Extract the Address field from each house document and convert it to a list
  final houses = housesSnap.docs.map((doc) => doc.data()['Address']).toList();

  // Return the home and houses data as a map
  return {'home': home, 'houses': houses};
}

// Function to send data to the Flask server
void sendData() async {
  // Define the URL of the Flask server
  String url = 'http://10.0.2.2:5000/receive_user_data';
  // Define the user ID
  String userId = '1';
  // Get the user data from Firestore
  Map<String, dynamic> userData = await getUserData(userId);

  // Make a POST request to the Flask server
  http.Response response = await http.post(
    // Parse the URL
    Uri.parse(url),
    // Set the content type header to application/json
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    // Encode the request body as JSON
    body: jsonEncode(<String, dynamic>{
      // Use the user ID as the username
      'username': userId,
      // Send the list of houses as the addresses
      'addresses': userData['houses'],
    }),
  );

  // Check the status code of the response
  if (response.statusCode == 200) {
    // If the status code is 200, print a success message
    print('Data sent successfully');
  } else {
    // If the status code is not 200, print an error message
    print('Failed to send data. Error: ${response.statusCode}');
  }
}



// Future<void> receiveData() async {
//   final url = Uri.parse('http://127.0.0.1:5000/receive_user_data');
  
//   // Await the getUserData() function call to get the actual data
//   final userData = await getUserData('1');
//   final houses = userData['houses'];
  
//   final response = await http.post(
//     url,
//     body: {
//       'username': '1',
//       'houses': jsonEncode(houses), // Assuming houses is a List<Map<String, dynamic>>
//     },
//   );

//   if (response.statusCode == 200) {
//     print('Data sent successfully');
//   } else {
//     print('Failed to send data. Error: ${response.statusCode}');
//   }
// }