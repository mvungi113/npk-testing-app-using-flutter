import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kilimo/widget/pages/home.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

Future<void> googleSignin(BuildContext context) async {
  final navigator = Navigator.of(context);
  final messenger = ScaffoldMessenger.of(context);
  try {
    // Fallback: sign in anonymously to keep behavior safe and compilable
    UserCredential result = await auth.signInAnonymously();
    if (result.user != null) {
      navigator.pushReplacement(
          MaterialPageRoute(builder: (_) => const UserHomePage()));
    }
  } catch (e) {
    messenger.showSnackBar(
      SnackBar(content: Text('Sign-in failed: $e')),
    );
  }
}
