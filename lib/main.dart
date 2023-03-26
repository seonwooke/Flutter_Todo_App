import 'package:flutter/material.dart';
import 'package:todo_app/bindings/binding.dart';
import 'package:todo_app/constants/routes/routes.dart';
import 'package:todo_app/firebase_options.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      designSize: const Size(375, 812),
      builder: ((context, child) => GetMaterialApp(
            initialBinding: InitBinding(),
            initialRoute: AppRoutes.instance.INIT,
            getPages: AppPages.instance.pages,
            defaultTransition: Transition.native,
          )),
    );
  }
}
