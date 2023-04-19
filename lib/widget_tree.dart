import 'package:accident_detection/auth.dart';
import 'package:accident_detection/pages/login_register_page.dart';
import 'package:flutter/material.dart';
import 'bottomBar.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // return HomePage();
          // return const HomePagee();
          return const MyBottomBar();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
