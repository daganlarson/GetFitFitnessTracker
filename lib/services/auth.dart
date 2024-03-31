
import 'package:firebase_auth/firebase_auth.dart';

abstract class BasicAuth {
  Future<String?> getUserId();
  Future<bool> authenticated();
  Future<String?> login(String email, String password);
}

class Auth implements BasicAuth {

  @override
  Future<bool> authenticated() async {
    // TODO implement users and authentication
    return true;
  }

  @override
  Future<String> getUserId() async {
    User? user = FirebaseAuth.instance.currentUser;
    return "Vv3z8wmZVfgsby0yaj7agaQarL72";
  }

  @override
  Future<String?> login(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print('login credentials invalid');
    }
    return null;
  }
}