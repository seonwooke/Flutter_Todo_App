import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../auth/auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarWidget(),
      body: _bodyWidget(),
    );
  }

  _appBarWidget() {
    return AppBar(
      title: const Text('HOME'),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.exit_to_app,
          ),
          onPressed: () async {
            try {
              await Authentication.instance.signOut();
            } catch (e) {
              if (kDebugMode) {
                print(e);
              }
            }
          },
        )
      ],
    );
  }

  _bodyWidget() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'TODO',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                    color: Colors.blue,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: const Icon(
                    Icons.add_box,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
