import 'package:flutter/material.dart';
import 'ui/login_screen.dart';
import 'ui/register_screen.dart';
import 'ui/main_screen.dart';
import 'ui/profile_screen.dart';
import 'ui/myfriend_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MobileFinal2',
      theme: ThemeData(
        primaryColor: Color(0xFFf06292),
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => LoginScreen(),
        "/register": (context) => RegisterScreen(),
        "/home": (context) => MainScreen(),
        "/profile": (context) => ProfileScreen(),
        "/friend": (context) => MyFriendScreen(),
      },
    );
  }
}