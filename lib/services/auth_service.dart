import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign in with email and password
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  // Register with email and password
  Future<User?> registerWithEmailAndPassword(
    String email,
    String password,
    String username,
  ) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      // Jika registrasi berhasil, buat dokumen pengguna di Firestore
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'email': email,
          'username': username,
          'emailVerified': false, // Set initial value to false
          'createdAt': FieldValue.serverTimestamp(),
          'profileUrl': '',
        });
        // Kirim email verifikasi
        await user.sendEmailVerification();
      }
      return user;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // Get current user
  User? getCurrentUser() {
    try {
      User? user = _auth.currentUser;
      return user;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  String? getUserId() {
    return getCurrentUser()?.uid;
  }

  Future<UserCredential> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      return await _auth.signInWithCredential(credential);
    } catch (e) {
      // Handle any errors
      debugPrint('Error signing in with Google: $e');
      rethrow;
    }
  }

  Future<bool> isUsernameAvailable(String username) async {
    final querySnapshot = await _firestore
        .collection('users')
        .where('username', isEqualTo: username)
        .get();
    return querySnapshot.docs.isEmpty;
  }

  Future<String?> getUsernameFromFirestore() async {
    try {
      final DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(getUserId()).get();

      if (userDoc.exists) {
        final data = userDoc.data() as Map<String, dynamic>?;
        return data?['username'] as String?;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Error getting username: $e');
      return null;
    }
  }

  Future<void> updateUsernameInFirestore(String newUsername) async {
    try {
      await _firestore
          .collection('users')
          .doc(getUserId())
          .update({'username': newUsername});
    } catch (e) {
      debugPrint('Error updating username: $e');
    }
  }

  Future<String?> getProfileURLFromFirestore() async {
    try {
      final DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(getUserId()).get();
      if (userDoc.exists) {
        final data = userDoc.data() as Map<String, dynamic>?;
        return data?['profileUrl'] as String?;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Error getting profileUrl: $e');
      return null;
    }
  }

  Future<void> updateProfileURLInFirestore(String newProfileUrl) async {
    try {
      await _firestore
          .collection('users')
          .doc(getUserId())
          .update({'profileUrl': newProfileUrl});
    } catch (e) {
      debugPrint('Error updating profileUrl: $e');
    }
  }
}
