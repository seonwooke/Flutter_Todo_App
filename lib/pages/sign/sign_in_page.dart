import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';
import 'package:todo_app/controllers/controllers.dart';
import 'package:todo_app/pages/pages.dart';

import '../../auth/auth.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});

  final signController = Get.put(SignController());

  final formKey = GlobalKey<FormState>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
      title: const Text('SIGN IN'),
    );
  }

  _bodyWidget() {
    return Center(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Obx(() {
            return signController.loging.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
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

                      /// SIGN UP BUTTON
                      Padding(
                        padding: EdgeInsets.only(
                          top: 8.h,
                          left: 260.0.w,
                        ),
                        child: InkWell(
                          onTap: () {
                            Get.to(() => SignUpPage());
                          },
                          child: Text(
                            '회원가입하기',
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      ),

                      /// SIGN IN BUTTON
                      Padding(
                        padding: const EdgeInsets.only(top: 120.0),
                        child: InkWell(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              signController.start();
                              Authentication.instance
                                  .signInWithEmailAndPassword(
                                _emailController.text.trim(),
                                _passwordController.text.trim(),
                              );
                              signController.done();
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
                                "로그인",
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
                  );
          }),
        ),
      ),
    );
  }
}
