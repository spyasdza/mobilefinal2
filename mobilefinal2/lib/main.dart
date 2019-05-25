import 'package:flutter/material.dart';
import 'ui/login_screen.dart';
import 'ui/register_screen.dart';
// import 'package:flutter_prepared/ui/friend_page.dart';
// import 'package:flutter_prepared/ui/home_page.dart';
// import 'package:flutter_prepared/ui/profile_page.dart';
// import 'package:flutter_prepared/ui/register_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Prepared',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFFf06292),
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => LoginScreen(),
        "/register": (context) => RegisScreen(),
        // "/home": (context) => HomePage(),
        // "/profile": (context) => ProfilePage(),
        // "/friend": (context) => FriendPage(),
      },
    );
  }
}