import 'package:flutter/material.dart';
import './ui/login_page.dart';
import './ui/home_page.dart';
import './ui/register_page.dart';
import './ui/profile_page.dart';

void main() => runApp(MyApp());

// const MaterialColor myColor =
//     const MaterialColor(0xfffdd835, const <int, Color>{
//   50: const Color(0xfffdd835),
//   100: const Color(0xfffdd835),
//   200: const Color(0xfffdd835),
//   300: const Color(0xfffdd835),
//   400: const Color(0xfffdd835),
//   500: const Color(0xfffdd835),
//   600: const Color(0xfffdd835),
//   700: const Color(0xfffdd835),
//   800: const Color(0xfffdd835),
//   900: const Color(0xfffdd835),
// });

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Color(0xfffdd835)),
      initialRoute: '/',
      routes: {
        "/": (context) => LoginPage(),
        "/home_page": (context) => HomePage(),
        "/register_page": (context) => RegisterPage(),
        "/proflie": (context) => Profile()
      },
    );
  }
}
