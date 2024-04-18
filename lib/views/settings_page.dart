import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/LoginProvider.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import 'components/notifier.dart';

import 'components/youtube_player.dart';



class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  //Detecting the user's login history.
  //If it's user's first login in a new day, encouragement dialog will be called.
  //This function will be improved when calendar system is ready.
  late SharedPreferences prefs;
  @override
  void initState() {
    super.initState();
    initSharedPreferences();
  }

  Future<void> initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    checkFirstOpen();
  }

  void checkFirstOpen() {
    final lastOpenTimestamp = prefs.getInt('last_open_timestamp') ?? 0;
    final todayTimestamp = DateTime.now().millisecondsSinceEpoch;

    final DateTime lastOpenDate = DateTime.fromMillisecondsSinceEpoch(lastOpenTimestamp);
    final DateTime todayDate = DateTime.fromMillisecondsSinceEpoch(todayTimestamp);

    if (lastOpenDate.day != todayDate.day) {
      dailyLoginCheers(context);
      prefs.setInt('last_open_timestamp', todayTimestamp);
    }
  }

  void logout() {
    Provider.of<LoginStatus>(context, listen: false).signOut();
  }

  void player(){

  }

  //video player button on right top corner
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('Settings'),
        actions: [
          IconButton(
            icon: Icon(Icons.music_video_outlined),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Youtube_Player()),
              );
            }
          ),
        ],
      ),
      body: Center(
        child: ElevatedButton(onPressed: logout, child: const Text("Logout"),),
      )
    );
  }

}