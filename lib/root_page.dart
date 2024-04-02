import 'package:binarybrigade/views/home_page.dart';
import 'package:binarybrigade/views/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class RootPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RootPageState();

}

class _RootPageState extends State<RootPage> {
  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser == null) {
      return LoginPage();
    } else {
      return HomePage();
    }
  }

}