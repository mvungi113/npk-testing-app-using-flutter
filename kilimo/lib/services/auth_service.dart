import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart';
import '../models/user_model.dart';
import '../supabase_config.dart';

class AuthService {
  final SupabaseClient _supabase = SupabaseConfig.client;

  // Stream to listen to auth state changes
  Stream<AuthState> get authStateChanges => _supabase.auth.onAuthStateChange;

  // Get current user
  User? get currentUser => _supabase.auth.currentUser;

  // Sign in with Google (Note: Supabase handles OAuth differently)
  Future<bool> signInWithGoogle() async {
    try {
      await _supabase.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: kIsWeb ? null : 'com.example.kilimo://login-callback',
      );
      return true;
    } on AuthException catch (e) {
      debugPrint('Auth error signing in with Google: ${e.message}');
      throw Exception(e.message);
    } catch (e) {
      debugPrint('Error signing in with Google: $e');
      throw Exception('An error occurred while signing in with Google');
    }
  }

  // Sign in with email and password
  Future<AuthResponse?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return response;
    } on AuthException catch (e) {
      debugPrint('Auth error signing in: ${e.message}');
      throw Exception(e.message);
    } catch (e) {
      debugPrint('Error signing in with email: $e');
      throw Exception('An error occurred while signing in');
    }
  }

  // Create user with email and password
  Future<AuthResponse?> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
      );
      return response;
    } on AuthException catch (e) {
      debugPrint('Auth error creating user: ${e.message}');
      throw Exception(e.message);
    } catch (e) {
      debugPrint('Error creating user with email: $e');
      throw Exception('An error occurred while creating account');
    }
  }

  // Sign in anonymously
  Future<AuthResponse?> signInAnonymously() async {
    try {
      final response = await _supabase.auth.signInAnonymously();
      return response;
    } on AuthException catch (e) {
      debugPrint('Auth error signing in anonymously: ${e.message}');
      throw Exception(e.message);
    } catch (e) {
      debugPrint('Error signing in anonymously: $e');
      throw Exception('An error occurred while signing in as guest');
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
    } catch (e) {
      debugPrint('Error signing out: $e');
    }
  }

  // Save user profile to Supabase
  Future<void> saveUserProfile(UserModel user) async {
    try {
      await _supabase.from('users').upsert(user.toMap());
    } catch (e) {
      debugPrint('Error saving user profile: $e');
      rethrow;
    }
  }

  // Get user profile from Supabase
  Future<UserModel?> getUserProfile(String uid) async {
    try {
      final response = await _supabase
          .from('users')
          .select()
          .eq('uid', uid)
          .single();

      return UserModel.fromMap(uid, response);
    } catch (e) {
      debugPrint('Error getting user profile: $e');
      return null;
    }
  }

  // Stream user profile changes
  Stream<UserModel?> getUserProfileStream(String uid) {
    return _supabase
        .from('users')
        .stream(primaryKey: ['uid'])
        .eq('uid', uid)
        .map((data) {
          if (data.isNotEmpty) {
            return UserModel.fromMap(uid, data.first);
          }
          return null;
        });
  }
}
