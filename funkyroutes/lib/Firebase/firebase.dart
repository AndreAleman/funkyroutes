// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
// import 'package:dio/dio.dart'; 

// class FirebaseService {
//   static Future<void> initializeFirebase() async {
//     try {
//       await Firebase.initializeApp(
//         options: DefaultFirebaseOptions.currentPlatform,
//       );
//       print('Connected to Firestore successfully.');
//     } catch (e) {
//       print('Failed to connect to Firestore: $e');
//     }
//   }

//   Future<Map<String, dynamic>> getUserData(String userId) async {
//   final userDoc = await FirebaseFirestore.instance.collection('Users').doc(userId).get(); //retrieve user doc form Users collection
//   final housesSnap = await FirebaseFirestore.instance.collection('Users').doc(userId).collection('Houses').get(); // Retrieving the houses subcollection for the user

//   final home = userDoc.data()?['home']; // Extracting the 'home' field from the user document
//   final houses = housesSnap.docs.map((doc) => doc.data()['Address']).toList(); // Extracting the 'Address' field from each house document and creating a list

//   return {'home': home, 'houses': houses}; // Returning a map containing the 'home' and 'houses' data
// }

// Future<Map<String, dynamic>> getTravelTimes(Map<String, dynamic> userData, String apiKey) async {
//   final home = userData['home']; // Extracting the 'home' data from the provided userData map
//   final houses = userData['houses']; // Extracting the 'houses' data from the provided userData map

//   final origins = [home, ...houses].map((location) => '${location['Street']}, ${location['City']}, ${location['State']}').join('|'); // Creating a string of origins by combining the 'Street', 'City', and 'State' fields of each location
//   final destinations = origins; // Setting the destinations to be the same as the origins

//   final response = await Dio().get('https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=$origins&destinations=$destinations&key=$apiKey'); // Making an HTTP GET request to the Google Distance Matrix API to get travel times

//   final travelTimes = response.data['rows'].map((row) => row['elements'].map((element) => element['duration']['value']).toList()).toList(); // Extracting the travel times from the API response

//   return {'travelTimes': travelTimes};// Returning a map containing the travel times
// }

// Future<void> updateOrder(String userId, List<String> fastestRoute) async {
//   final batch = FirebaseFirestore.instance.batch(); // Creating a batch write operation for updating multiple documents

//   List<String> route = [userId, ...fastestRoute]; // Create a new list that starts with the user ID and appends the houses in the fastest route

//   for (var i = 0; i < route.length; i++) {
//     final houseRef = FirebaseFirestore.instance.collection('Users').doc(route[i]).collection('Houses').doc(route[i]); // Creating a reference to each house document in the 'Houses' subcollection
//     batch.update(houseRef, {'Order': i + 1}); // Updating the 'Order' field of each house document in the batch
//   }

//   await batch.commit(); // Committing the batch write operation to update all the house documents

//   print('The houses in order:');
//   for (var i = 1; i < route.length; i++) {
//     final houseDoc = await FirebaseFirestore.instance.collection('Users').doc(route[i]).collection('Houses').doc(route[i]).get(); // Retrieve the house document
//     final address = houseDoc.data()?['Address']; // Extract the address from the house document
//     print('House ${route[i]}: $address'); // Print the house ID and its address
//   }
// }



//   // static Future<void> getUserData() async {
//   //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   //   await _firestore.collection('Users').doc('1').get().then((DocumentSnapshot documentSnapshot) {
//   //     if (documentSnapshot.exists) {
//   //       print('Document data: ${documentSnapshot.data()}');
//   //     } else {
//   //       print('Error: Document does not exist');
//   //     }
//   //   });
//   // }
// }
