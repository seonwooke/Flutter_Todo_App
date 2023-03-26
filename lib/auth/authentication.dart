import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../constants/constants.dart';
import '../models/models.dart';
import '../repositories/repositories.dart';

class Authentication {
  Authentication._privateConstructor();
  static final Authentication _instance = Authentication._privateConstructor();

  static Authentication get instance => _instance;

  /// 이메일 회원가입
  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = result.user;

      if (user != null) {
        await UserRepository.instance.addUserToFirebase(
          UserModel.emailSignUp(
            user,
          ),
        );
        Get.offNamed(AppRoutes.instance.HOME);

        return user;
      }

      return user;
    } on FirebaseAuthException catch (e) {
      errorSnackBar(e);
    } catch (e) {
      if (kDebugMode) {
        print('sign up failed');
        print(e.toString());
      }

      return null;
    }

    return null;
  }

  /// 이메일 로그인
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      User? user = result.user;

      if (user != null) {
        Get.offNamed(AppRoutes.instance.HOME);
      } else {
        await signOut();
      }
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    } on FirebaseAuthException catch (e) {
      errorSnackBar(e);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  /// 이메일 로그아웃
  Future<void> signOut() async {
    await FirebaseAuth.instance
        .signOut()
        .then((value) => Get.offAllNamed(AppRoutes.instance.SIGNIN));
  }

  /// 에러 스넥바
  void errorSnackBar(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        Get.snackbar(
          '유효하지 않는 이메일',
          '유효하지 않는 이메일 형식입니다.🙁',
        );
        break;
      case 'user-not-found':
        Get.snackbar(
          '존재하지 않는 이메일 입니다.',
          '회원가입을 먼저 해주세요.🙁',
        );
        break;
      case 'wrong-password':
        Get.snackbar(
          '패스워드가 틀렸습니다.',
          '패스워드를 확인 해주세요.🙁\n구글 혹은 애플 계정으로 로그인한 경우일 수 있습니다.',
        );
        break;
      case 'network-request-failed':
        Get.snackbar(
          '네트워크 오류',
          '모바일 네트워크 혹은 와이파이를 확인해 주세요.🙁',
        );
        break;
      case 'email-already-in-use':
        Get.snackbar(
          '이메일 중복',
          '해당 이메일은 이미 존재합니다.🙁',
        );
        break;
      case 'weak-password':
        Get.snackbar(
          '너무 쉬운 비밀번호',
          '비밀번호를 6자 이상으로 입력해주세요.🙁',
        );
        break;
      case 'operation-not-allowed':
        Get.snackbar(
          '허용되지 않는 방법',
          '허용되지 않은 로그인 방법입니다.🙁',
        );
        break;
      default:
        Get.snackbar(
          e.code,
          '${e.message}',
          duration: const Duration(seconds: 5),
        );
    }
  }
}
