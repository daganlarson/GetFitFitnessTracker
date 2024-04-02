import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/LoginProvider.dart';



class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  void logout() {
    Provider.of<LoginStatus>(context, listen: false).signOut();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(onPressed: logout, child: const Text("Logout"),),
      )
    );
  }
  
}