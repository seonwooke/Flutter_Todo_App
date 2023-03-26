import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

import '../../auth/auth.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final formKey = GlobalKey<FormState>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBarWidget(),
      body: _bodyWidget(),
    );
  }

  _appBarWidget() {
    return AppBar(
      title: const Text('SIGN UP'),
    );
  }

  _bodyWidget() {
    return Center(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// Rive
              SizedBox(
                height: 100.h,
                width: 100.w,
                child: const RiveAnimation.asset(
                  'assets/rives/dog.riv',
                ),
              ),

              /// Email TextField
              Padding(
                padding: const EdgeInsets.only(top: 48.0),
                child: Container(
                  width: 350.w,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12.w),
                  ),
                  child: TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return '이메일을 입력하세요.';
                      } else if (!value.isEmail) {
                        return '이메일 형식이 잘못되었습니다.';
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: '이메일을 입력해 주세요.',
                      prefixIcon: Icon(
                        Icons.email,
                      ),
                      contentPadding: EdgeInsets.only(top: 14),
                    ),
                  ),
                ),
              ),

              /// Password TextField
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  width: 350.w,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12.w),
                  ),
                  child: TextFormField(
                    controller: _passwordController,
                    autocorrect: false,
                    obscureText: true,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return '패스워드을 입력하세요.';
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: '패스워드를 입력해 주세요.',
                      prefixIcon: Icon(
                        Icons.key,
                      ),
                      contentPadding: EdgeInsets.only(top: 14),
                    ),
                  ),
                ),
              ),

              /// Password Confrim TextField
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  width: 350.w,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12.w),
                  ),
                  child: TextFormField(
                    controller: _passwordConfirmController,
                    autocorrect: false,
                    obscureText: true,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return '패스워드을 입력하세요.';
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: '패스워드를 입력해 주세요.',
                      prefixIcon: Icon(
                        Icons.key,
                      ),
                      contentPadding: EdgeInsets.only(top: 14),
                    ),
                  ),
                ),
              ),

              /// SIGN UP BUTTON
              Padding(
                padding: const EdgeInsets.only(top: 88.0),
                child: InkWell(
                  onTap: () async {
                    if (_passwordController.text ==
                        _passwordConfirmController.text) {
                      Authentication.instance.signUpWithEmailAndPassword(
                        _emailController.text.trim(),
                        _passwordController.text.trim(),
                      );
                    } else {
                      Get.snackbar(
                        '오류',
                        '비밀번호가 일치하지 않습니다',
                      );
                    }
                  },
                  child: Container(
                    height: 56.h,
                    width: 340.w,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(
                        Radius.circular(32),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "회원가입",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
