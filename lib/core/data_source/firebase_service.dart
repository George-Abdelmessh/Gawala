import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  FirebaseService._();

  static final FirebaseService _instance = FirebaseService._();

  factory FirebaseService() {
    return _instance;
  }

  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign up with email and password
  static Future<User?> signUp(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Sign in with email and password
  static Future<User?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Sign out
  static Future<void> signOut() async {
    await _auth.signOut();
  }

  // Get real-time data from Firestore
  static Stream<QuerySnapshot> getData({
    required String collection,
  }) {
    return _firestore.collection(collection).snapshots();
  }

  // Get real-time data from Firestore
  static Future<DocumentSnapshot> getSingleDoc({
    required String collection,
    required String id,
  }) {
    return _firestore.collection(collection).doc(id).get();
  }

  // Add data to Firestore
  static Future<void> addData({
    required String collection,
    required Map<String, dynamic> data,
    String? id,
  }) async {
    if (id != null) {
      await _firestore.collection(collection).doc(id).set(data);
    } else {
      await _firestore.collection(collection).add(data);
    }
  }

  // Update data in Firestore
  static Future<void> updateData(
      String collection, String docId, Map<String, dynamic> data) async {
    await _firestore.collection(collection).doc(docId).update(data);
  }

  // Delete data from Firestore
  static Future<void> deleteData(String collection, String docId) async {
    await _firestore.collection(collection).doc(docId).delete();
  }
}
