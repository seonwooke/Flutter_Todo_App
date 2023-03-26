import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';

class UserRepository {
  UserRepository._privateConstructor();
  static final UserRepository _instance = UserRepository._privateConstructor();

  static UserRepository get instance => _instance;

  final _userCollection = FirebaseFirestore.instance.collection("user");

  Future<UserModel> getUser(String uid) async {
    UserModel userModel = UserModel.empty();
    try {
      await _userCollection.doc(uid).get().then((DocumentSnapshot ds) {
        userModel = UserModel.fromMap(ds.data() as Map<String, dynamic>);
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
        print(userModel.toString());
      }
    }
    return userModel;
  }

  Future<void> addUserToFirebase(UserModel userModel) async {
    try {
      if (kDebugMode) {
        print(userModel);
      }
      await _userCollection.doc(userModel.uid).set(userModel.toMap());
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
