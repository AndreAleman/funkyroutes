// Import the necessary packages
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> getUserData(String userId) async {
  print('start get user');

  // Get the user document from Firestore
  final userDoc =
      await FirebaseFirestore.instance.collection('Users').doc(userId).get();
  // Get the houses documents from Firestore
  final housesSnap = await FirebaseFirestore.instance
      .collection('Users')
      .doc(userId)
      .collection('Houses')
      .get();

  // Extract the home field from the user document
  final home = userDoc.data()?['Home'];
  // Extract the Address field from each house document and convert it to a list
  final houses =
      housesSnap.docs.map((doc) => doc.data()['Address']).toList();

  // Return the home and houses data as a map
  print('inside the info_dart $home');
  print('end get user');
  return {'home': home, 'houses': houses};
}

// Function to send data to the Flask server
void sendData(Map<String, dynamic> userData) async {
  print('start senddata');
  // Define the URL of the Flask server
  String url = 'http://10.0.2.2:5000/receive_user_data';
  // Define the user ID
  String userId = '1';

  print('after userrrrrrr');
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

      'home' : userData['home'],
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
  print('end get data');
}


void getHouses() async {
  var url = Uri.parse('http://10.0.2.2:5000/get_houses');

  var response = await http.get(url);

  if (response.statusCode == 200) {
    // Successful response
    var housesData = response.body;
    print('it worked fa****s');
    // You can parse the housesData JSON string if needed
  } else {
    // Error response
    print('Failed to get houses data. Error code: ${response.statusCode}');
  }
}



void getHelloWorld(String message) async {
  // Define the URL of the Flask server
  String url = 'http://10.0.2.2:5000/hello';

  // Build the URL with query parameters
  Uri uri = Uri.parse(url).replace(queryParameters: {
    'message': message,
  });

  // Make a GET request to the Flask server
  http.Response response = await http.get(uri);

  // Check the status code of the response
  if (response.statusCode == 200) {
    // If the status code is 200, print the response body
    print('Response: ${response.body}');
  } else {
    // If the status code is not 200, print an error message
    print('HELLODIDNTWORK ${response.statusCode}');
  }
}


////HOW TO GET HOME FROM DATA