

import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String _username = "";
  int _permissions = 0;


  String get username => _username;
  set username(String name) {_username = name;}

  int get permissions => _permissions;

  User(String username, int permissions) {
    _username = username;
    _permissions = permissions;
  }

  factory User.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options,) {
    final data = snapshot.data();
    return User(data?['username'], data?['permissions']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      'username': _username,
      'permissions': _permissions,
    };
  }
}
