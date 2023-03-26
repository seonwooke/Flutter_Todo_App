import 'package:firebase_auth/firebase_auth.dart';

import '../constants/constants.dart';

class UserModel {
  LoginType loginType;
  String uid;
  String displayName;
  String email;
  String photoUrl;

  UserModel({
    required this.loginType,
    required this.uid,
    required this.displayName,
    required this.email,
    required this.photoUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'loginType': loginType.name,
      'uid': uid,
      'displayName': displayName,
      'email': email,
      'photoUrl': photoUrl,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      loginType: LoginType.values.byName(map['loginType'] as String),
      uid: map['uid'] as String,
      displayName: map['displayName'] as String,
      email: map['email'] as String,
      photoUrl: map['photoUrl'] as String,
    );
  }

  factory UserModel.empty() {
    return UserModel(
      loginType: LoginType.email,
      uid: '',
      displayName: '',
      email: '',
      photoUrl: '',
    );
  }

  factory UserModel.signUp(LoginType loginType, User user) {
    return UserModel(
      loginType: loginType,
      uid: user.uid,
      email: user.email!,
      displayName: DataUtils.instance.randomNicknameGenerator(),
      photoUrl: '',
    );
  }

  factory UserModel.emailSignUp(User user) {
    return UserModel.signUp(LoginType.email, user);
  }
}
