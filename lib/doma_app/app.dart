
import 'package:doma_app/doma_app/resources/dash_board/ui_view/doma_app_home_screen.dart';
import 'package:flutter/material.dart';

import 'resources/login_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}


