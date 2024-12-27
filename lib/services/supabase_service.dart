import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:cast_in/utils/helpers.dart';

class SupabaseService extends GetxService {
  SupabaseService(this._client);

  late final SupabaseClient _client;
  SupabaseClient get client => _client;

  // Auth state
  final Rx<User?> _user = Rx<User?>(null);
  User? get user => _user.value;

  static Future<SupabaseService> init() async {
    await Supabase.initialize(
      url: 'https://bwolquhldszmuhqasacn.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJ3b2xxdWhsZHN6bXVocWFzYWNuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzUzMTEwMjYsImV4cCI6MjA1MDg4NzAyNn0.BHJhYFfj5NS9exdjdkz_cWx-KquNXb-wRMxUvQ09Uk8',
    );
    return SupabaseService(Supabase.instance.client);
  }

  @override
  void onInit() {
    super.onInit();
    _initAuthListener();
  }

  void _initAuthListener() {
    _client.auth.onAuthStateChange.listen((data) {
      final AuthChangeEvent event = data.event;
      final Session? session = data.session;

      switch (event) {
        case AuthChangeEvent.signedIn:
          _user.value = session?.user;
          Helpers.appDebugger('User signed in: ${_user.value?.email}');
          break;
        case AuthChangeEvent.signedOut:
          _user.value = null;
          Helpers.appDebugger('User signed out');
          break;
        case AuthChangeEvent.userUpdated:
          _user.value = session?.user;
          Helpers.appDebugger('User updated: ${_user.value?.email}');
          break;
        default:
          break;
      }
    });
  }

  // Sign up with user data from signup form
  Future<void> signUp({
    required String fullName,
    required String username,
    required String password,
    required String phoneNumber,
    required String country,
    required String city,
  }) async {
    try {
      await _client.auth.signUp(
        phone: phoneNumber,
        password: password,
        data: {
          'full_name': fullName,
          'user_name': username,
          'country': country,
          'city': city,
        },
      );
    } catch (e) {
      Helpers.appDebugger('Error signing up', error: e);
      rethrow;
    }
  }

  // Sign in with email and password
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      Helpers.appDebugger('Error signing in', error: e);
      rethrow;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _client.auth.signOut();
    } catch (e) {
      Helpers.appDebugger('Error signing out', error: e);
      rethrow;
    }
  }

  // Reset password
  Future<void> resetPassword(String email) async {
    try {
      await _client.auth.resetPasswordForEmail(email);
    } catch (e) {
      Helpers.appDebugger('Error resetting password', error: e);
      rethrow;
    }
  }

  // Update user profile
  Future<void> updateProfile({
    String? username,
    String? avatarUrl,
  }) async {
    try {
      final UserAttributes userAttributes = UserAttributes(
        data: {
          if (username != null) 'username': username,
          if (avatarUrl != null) 'avatar_url': avatarUrl,
        },
      );
      await _client.auth.updateUser(userAttributes);
    } catch (e) {
      Helpers.appDebugger('Error updating profile', error: e);
      rethrow;
    }
  }
}
