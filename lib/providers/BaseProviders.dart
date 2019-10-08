import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wechat/models/Chat.dart';
import 'package:wechat/models/Contact.dart';
import 'package:wechat/models/Message.dart';
import 'package:wechat/models/User.dart';

abstract class BaseAuthenticationProvider{
  Future<FirebaseUser> signInWithGoogle();
  Future<void> signOutUser();
  Future<FirebaseUser> getCurrentUser();
  Future<bool> isLoggedIn();
}

abstract class BaseUserDataProvider{
  Future<User> saveDetailsFromGoogleAuth(FirebaseUser user);
  Future<User> saveProfileDetails(String profileImageUrl, int age, String username);
  Future<bool> isProfileComplete();
  Stream<List<Contact>> getContacts();
  Future<void> addContact(String username);
  Future<User> getUser(String username);
  Future<String> getUidByUsername(String username);
}

abstract class BaseStorageProvider{
  Future<String> uploadFile(File file, String path);
}

abstract class BaseChatProvider{
  Stream<List<Message>> getMessages(String chatId);
  Stream<List<Chat>> getChats();
  Future<void> sendMessage(String chatId, Message message);
  Future<String> getChatIdByUsername(String username);
  Future<void> createChatIdForContact(User user);
}