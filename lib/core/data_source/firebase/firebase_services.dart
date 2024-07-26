// Auth -> Email & password (SingIn, SignUp, Logout)
//
// Add Date
// Get Data
// Update Data
// Delete
//
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseServices {
  FirebaseServices._();

  static final FirebaseServices _instance = FirebaseServices._();

  factory FirebaseServices() => _instance;

  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  static Future<User?> signUp(String email, String password) async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential.user;
    } catch (e) {
      debugPrint("Error: $e");
      return null;
    }
  }

  static Future<User?> signIn(String email, String password) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential.user;
    } catch (e) {
      debugPrint("Error: $e");
      return null;
    }
  }

  static Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  static Future<void> addData({
    required final String collection,
    required final Map<String, dynamic> data,
    final String? id,
  }) async {
    try {
      if (id != null) {
        /// Add with Custom ID
        await firestore.collection(collection).doc(id).set(data);
      } else {
        /// Add with Auto-Generated ID
        final doc = firestore.collection(collection).doc();
        final Map<String, dynamic> dataWithId = data;
        dataWithId['id'] = doc.id;
        await doc.set(dataWithId);
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  static Future<QuerySnapshot> getData({
    required final String collection,
  }) async {
    return await firestore.collection(collection).get();
  }

  static Stream<QuerySnapshot> getDataStream({
    required final String collection,
  }) {
    return firestore.collection(collection).snapshots();
  }

  static Future<DocumentSnapshot<Map<String, dynamic>>> getSingleDoc({
    required final String collection,
    required final String id,
  }) async {
    return await firestore.collection(collection).doc(id).get();
  }

  static Future<void> updateDoc({
    required final String collection,
    required final String id,
    required final Map<String, dynamic> data,
  }) async {
    return await firestore.collection(collection).doc(id).update(data);
  }

  static Future<void> deleteDoc({
    required final String collection,
    required final String id,
  }) async {
    return await firestore.collection(collection).doc(id).delete();
  }
}
