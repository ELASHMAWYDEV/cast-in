import 'package:cast_in/utils/app_enums.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:cast_in/utils/helpers.dart';
import 'package:cast_in/models/user_model.dart';
import 'package:cast_in/models/post_model.dart';
import 'package:cast_in/models/message_model.dart';
import 'package:cast_in/models/notification_model.dart';

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

  // Auth Methods
  Future<void> signUp({
    required String fullName,
    required String username,
    required String password,
    required String phoneNumber,
    required String country,
    required String city,
    required UserType userType,
  }) async {
    try {
      await _client.auth.signUp(
        phone: phoneNumber,
        password: password,
      );

      switch (userType) {
        case UserType.client:
          await _client.from('clients').insert({
            'id': _client.auth.currentUser!.id,
            'full_name': fullName,
            'user_name': username,
            'country': country,
            'city': city,
            'user_type': userType.toString(),
          });
          break;
        case UserType.model:
          await _client.from('models').insert({
            'id': _client.auth.currentUser!.id,
            'full_name': fullName,
            'user_name': username,
            'country': country,
            'city': city,
            'user_type': userType.toString(),
          });
          break;
        default:
          break;
      }
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

  Future<void> signOut() async {
    try {
      await _client.auth.signOut();
    } catch (e) {
      Helpers.appDebugger('Error signing out', error: e);
      rethrow;
    }
  }

  // User Methods
  Future<UserModel?> getUserProfile(String userId) async {
    try {
      final response = await _client.from('clients').select().eq('id', userId).single();
      return response != null ? UserModel.fromMap(response) : null;
    } catch (e) {
      Helpers.appDebugger('Error getting user profile', error: e);
      rethrow;
    }
  }

  Future<void> updateUserProfile(UserModel user) async {
    try {
      await _client.from('clients').update(user.toMap()).eq('id', user.id);
    } catch (e) {
      Helpers.appDebugger('Error updating user profile', error: e);
      rethrow;
    }
  }

  // Post Methods
  Future<List<PostModel>> getPosts({int limit = 10, int offset = 0}) async {
    try {
      final response =
          await _client.from('posts').select().order('created_at', ascending: false).range(offset, offset + limit - 1);
      return (response as List).map((post) => PostModel.fromMap(post)).toList();
    } catch (e) {
      Helpers.appDebugger('Error getting posts', error: e);
      rethrow;
    }
  }

  Future<PostModel> createPost(PostModel post) async {
    try {
      final response = await _client.from('posts').insert(post.toMap()).select().single();
      return PostModel.fromMap(response);
    } catch (e) {
      Helpers.appDebugger('Error creating post', error: e);
      rethrow;
    }
  }

  Future<void> deletePost(String postId) async {
    try {
      await _client.from('posts').delete().eq('id', postId);
    } catch (e) {
      Helpers.appDebugger('Error deleting post', error: e);
      rethrow;
    }
  }

  Future<void> updatePost(PostModel post) async {
    try {
      await _client.from('posts').update(post.toMap()).eq('id', post.id);
    } catch (e) {
      Helpers.appDebugger('Error updating post', error: e);
      rethrow;
    }
  }

  // Message Methods
  Future<List<MessageModel>> getMessages(String userId, {int limit = 20}) async {
    try {
      final response = await _client
          .from('messages')
          .select()
          .or('sender_id.eq.$userId,receiver_id.eq.$userId')
          .order('created_at', ascending: false)
          .limit(limit);
      return (response as List).map((msg) => MessageModel.fromMap(msg)).toList();
    } catch (e) {
      Helpers.appDebugger('Error getting messages', error: e);
      rethrow;
    }
  }

  Future<MessageModel> sendMessage(MessageModel message) async {
    try {
      final response = await _client.from('messages').insert(message.toMap()).select().single();
      return MessageModel.fromMap(response);
    } catch (e) {
      Helpers.appDebugger('Error sending message', error: e);
      rethrow;
    }
  }

  Future<void> markMessageAsRead(String messageId) async {
    try {
      await _client.from('messages').update({'is_read': true}).eq('id', messageId);
    } catch (e) {
      Helpers.appDebugger('Error marking message as read', error: e);
      rethrow;
    }
  }

  // Notification Methods
  Future<List<NotificationModel>> getNotifications(String userId, {int limit = 20}) async {
    try {
      final response = await _client
          .from('notifications')
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false)
          .limit(limit);
      return (response as List).map((notif) => NotificationModel.fromMap(notif)).toList();
    } catch (e) {
      Helpers.appDebugger('Error getting notifications', error: e);
      rethrow;
    }
  }

  Future<void> markNotificationAsRead(String notificationId) async {
    try {
      await _client.from('notifications').update({'is_read': true}).eq('id', notificationId);
    } catch (e) {
      Helpers.appDebugger('Error marking notification as read', error: e);
      rethrow;
    }
  }

  Future<NotificationModel> createNotification(NotificationModel notification) async {
    try {
      final response = await _client.from('notifications').insert(notification.toMap()).select().single();
      return NotificationModel.fromMap(response);
    } catch (e) {
      Helpers.appDebugger('Error creating notification', error: e);
      rethrow;
    }
  }

  // Follower Methods
  Future<List<UserModel>> getFollowers(String userId) async {
    try {
      final response = await _client.from('followers').select('follower_id(*)').eq('following_id', userId);
      return (response as List).map((follower) => UserModel.fromMap(follower['follower_id'])).toList();
    } catch (e) {
      Helpers.appDebugger('Error getting followers', error: e);
      rethrow;
    }
  }

  Future<List<UserModel>> getFollowing(String userId) async {
    try {
      final response = await _client.from('followers').select('following_id(*)').eq('follower_id', userId);
      return (response as List).map((following) => UserModel.fromMap(following['following_id'])).toList();
    } catch (e) {
      Helpers.appDebugger('Error getting following', error: e);
      rethrow;
    }
  }

  Future<void> followUser(String followerId, String followingId) async {
    try {
      await _client.from('followers').insert({
        'follower_id': followerId,
        'following_id': followingId,
      });
    } catch (e) {
      Helpers.appDebugger('Error following user', error: e);
      rethrow;
    }
  }

  Future<void> unfollowUser(String followerId, String followingId) async {
    try {
      await _client.from('followers').delete().eq('follower_id', followerId).eq('following_id', followingId);
    } catch (e) {
      Helpers.appDebugger('Error unfollowing user', error: e);
      rethrow;
    }
  }

  // Model Methods
  Future<List<UserModel>> getModels({int limit = 10, int offset = 0}) async {
    try {
      final response =
          await _client.from('models').select().order('created_at', ascending: false).range(offset, offset + limit - 1);
      return (response as List).map((model) => UserModel.fromMap(model)).toList();
    } catch (e) {
      Helpers.appDebugger('Error getting models', error: e);
      rethrow;
    }
  }

  Future<UserModel?> getModelProfile(String modelId) async {
    try {
      final response = await _client.from('models').select().eq('id', modelId).single();
      return response != null ? UserModel.fromMap(response) : null;
    } catch (e) {
      Helpers.appDebugger('Error getting model profile', error: e);
      rethrow;
    }
  }

  Future<void> updateModelProfile(UserModel model) async {
    try {
      await _client.from('models').update(model.toMap()).eq('id', model.id);
    } catch (e) {
      Helpers.appDebugger('Error updating model profile', error: e);
      rethrow;
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _client.auth.resetPasswordForEmail(email);
    } catch (e) {
      Helpers.appDebugger('Error resetting password', error: e);
      rethrow;
    }
  }
}
