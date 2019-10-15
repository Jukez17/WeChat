import 'package:firebase_auth/firebase_auth.dart';
import 'package:wechat/models/Contact.dart';
import 'package:wechat/models/User.dart';
import 'package:wechat/providers/BaseProviders.dart';
import 'package:wechat/providers/UserDataProvider.dart';
import 'package:wechat/repositories/BaseRepository.dart';

class UserDataRepository extends BaseRepository {
  BaseUserDataProvider userDataProvider = UserDataProvider();

  Future<User> saveDetailsFromGoogleAuth(FirebaseUser user) =>
      userDataProvider.saveDetailsFromGoogleAuth(user);

  Future<User> saveProfileDetails(
          String uid, String profileImageUrl, int age, String username) =>
      userDataProvider.saveProfileDetails(profileImageUrl, age, username);

  Future<bool> isProfileComplete() => userDataProvider.isProfileComplete();

  Stream<List<Contact>> getContacts() => userDataProvider.getContacts();

  Future<void> addContact(String username) =>
      userDataProvider.addContact(username);

  Future<User> getUser(String username) => userDataProvider.getUser(username);

  @override
  void dispose() {
    userDataProvider.dispose();
  }
}