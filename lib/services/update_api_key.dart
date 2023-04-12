import 'package:brahma/constants/api_key.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


// creating instance of Firebase auth
final FirebaseAuth _auth = FirebaseAuth.instance;


// creating a reference to to the firebase collection
final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

// Setting Initial Master API KEY which is my own api key
String masterAPIKey = openAIAPIKey; // constant api

// user api key's initial default value is = masterAPIKey, then the user will update it, if they want.

// Add a new document for the current user with the initial values
void addUSerDocument(String userAPIKEY) async {
  User? user = _auth.currentUser;
  if(user!= null) {
    await usersCollection.doc(user.uid).set({
      'masterAPIKey': masterAPIKey,
      'userAPIKey' : userAPIKEY
    });
  }
}


// Update the current user's api key in the document
void updateUserAPIKey(String newAPI) async {
  User? user = _auth.currentUser;
  if(user != null){
    await usersCollection.doc(user.uid).update({'userAPIKey' : newAPI});
  }
}