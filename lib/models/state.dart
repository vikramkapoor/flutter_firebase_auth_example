import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_auth_brainframe/models/user.dart';
import 'package:flutter_firebase_auth_brainframe/models/settings.dart';

class StateModel {
  bool isLoading;
  FirebaseUser firebaseUserAuth;
  User user;
  Settings settings;

  StateModel({
    this.isLoading = false,
    this.firebaseUserAuth,
    this.user,
    this.settings,
  });
}
