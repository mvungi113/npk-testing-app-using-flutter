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
    final userCredential = await _authService.signInWithGoogle();
    if (userCredential != null && userCredential.user != null) {
      final user = userCredential.user!;
      // Check if user profile already exists
      final existingProfile = await _authService.getUserProfile(user.uid);
      if (existingProfile == null) {
        // Create user profile with Google account information
        final userModel = UserModel(
          uid: user.uid,
          email: user.email ?? '',
          fullName: user.displayName ?? '',
          phoneNumber: user.phoneNumber ?? '',
          profileImageUrl: user.photoURL ?? '',
        );
        await _authService.saveUserProfile(userModel);
      }
    }
  }

  Future<void> signInAnonymously() async {
    await _authService.signInAnonymously();
  }

  Future<void> signInWithEmail(String email, String password) async {
    await _authService.signInWithEmailAndPassword(email, password);
  }

  Future<void> signUpWithEmail(String email, String password) async {
    final userCredential = await _authService.createUserWithEmailAndPassword(
      email,
      password,
    );
    if (userCredential != null && userCredential.user != null) {
      // Create basic user profile immediately after sign up
      final userModel = UserModel(uid: userCredential.user!.uid, email: email);
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
