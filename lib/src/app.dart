import 'package:flutter/material.dart';
import 'package:flutter_app_grab/src/resources/login_page.dart';
class MyApp extends InheritedWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }
}
