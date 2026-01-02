import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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
    _authService.authStateChanges.listen((AuthState authState) async {
      _user = authState.session?.user;
      if (_user != null) {
        // Load user profile when user signs in
        _userModel = await _authService.getUserProfile(_user!.id);
        if (_userModel == null) {
          // Create basic user profile if it doesn't exist
          final userModel = UserModel(
            uid: _user!.id,
            email: _user!.email ?? '',
            fullName: _user!.userMetadata?['full_name'] ?? '',
            phoneNumber: _user!.userMetadata?['phone'] ?? '',
            profileImageUrl: _user!.userMetadata?['avatar_url'] ?? '',
          );
          await _authService.saveUserProfile(userModel);
          _userModel = userModel;
        }
        // Also listen to profile changes
        _authService.getUserProfileStream(_user!.id).listen((UserModel? model) {
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

  Future<void> signInWithEmail(String email, String password) async {
    try {
      final response = await _authService.signInWithEmailAndPassword(
        email,
        password,
      );
      if (response == null) {
        throw Exception('Failed to sign in. Please check your credentials.');
      }
    } catch (e) {
      throw Exception('Sign in error: ${e.toString()}');
    }
  }

  Future<void> signUpWithEmail(String email, String password) async {
    try {
      final authResponse = await _authService.createUserWithEmailAndPassword(
        email,
        password,
      );
      if (authResponse == null) {
        throw Exception('Failed to create account. Please try again.');
      }
      if (authResponse.user != null) {
        // Create basic user profile immediately after sign up
        final userModel = UserModel(uid: authResponse.user!.id, email: email);
        await _authService.saveUserProfile(userModel);
      }
    } catch (e) {
      throw Exception('Registration error: ${e.toString()}');
    }
  }

  Future<void> signInAnonymously() async {
    try {
      final authResponse = await _authService.signInAnonymously();
      if (authResponse == null) {
        throw Exception('Failed to sign in as guest. Please try again.');
      }
      if (authResponse.user != null) {
        // Create basic user profile for anonymous user
        final userModel = UserModel(
          uid: authResponse.user!.id,
          email: 'anonymous@guest.com', // Placeholder email for anonymous users
        );
        await _authService.saveUserProfile(userModel);
      }
    } catch (e) {
      throw Exception('Guest sign in error: ${e.toString()}');
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
