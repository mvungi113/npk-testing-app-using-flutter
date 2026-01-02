import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';
import '../models/user_model.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _user;
  UserModel? _userModel;

  User? get user => _user;
  UserModel? get userModel => _userModel;

  bool get isAuthenticated => _user != null;

  AuthProvider() {
    _authService.authStateChanges.listen((User? user) async {
      _user = user;
      if (user != null) {
        // Load user profile when user signs in
        _userModel = await _authService.getUserProfile(user.uid);
        // Also listen to profile changes
        _authService.getUserProfileStream(user.uid).listen((UserModel? model) {
          _userModel = model;
          notifyListeners();
        });
      } else {
        _userModel = null;
      }
      notifyListeners();
    });
  }

  Future<void> signInWithGoogle() async {
    await _authService.signInWithGoogle();
  }

  Future<void> signInAnonymously() async {
    await _authService.signInAnonymously();
  }

  Future<void> signInWithEmail(String email, String password) async {
    await _authService.signInWithEmailAndPassword(email, password);
  }

  Future<void> signUpWithEmail(
    String email,
    String password,
    String fullName, {
    String? phone,
    String? gender,
    String? country,
  }) async {
    final userCredential = await _authService.createUserWithEmailAndPassword(email, password);
    if (userCredential != null && userCredential.user != null) {
      // Create basic user profile immediately after sign up
      final userModel = UserModel(
        uid: userCredential.user!.uid,
        fullName: fullName,
        email: email,
        phoneNumber: phone,
        gender: gender,
        country: country,
      );
      await _authService.saveUserProfile(userModel);
    }
  }

  Future<void> saveUserProfile(UserModel user) async {
    await _authService.saveUserProfile(user);
    _userModel = user;
    notifyListeners();
  }

  Future<void> signOut() async {
    await _authService.signOut();
  }
}
