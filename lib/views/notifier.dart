import 'package:flutter/material.dart';

//Dialog for encouraging user to keep logging everyday.
void dailyLoginCheers(BuildContext context) {
  showDialog<Null>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Cheers!'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('You have used our app for *null* days!'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Lets go!'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

//Alert when internet is disconnected.
//The navigator to Wifi setting is not ready.
void internetAlertNotifier(BuildContext context) {
  showDialog<Null>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('No Internet Connection'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Wops! You lost connection with us!'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Go to Wifi Setting'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
