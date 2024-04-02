
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:binarybrigade/models/event.dart';
import 'package:url_launcher/url_launcher.dart';

class EventWidget extends StatelessWidget {
  Event thisEvent;
  EventWidget(Event myEvent, {super.key}) : thisEvent = myEvent;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 220,
        width: 350,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Column(
          children: [
            Text(thisEvent.name),
            Image.network(thisEvent.thumbnail),
          Text(thisEvent.address + "\n" + thisEvent.dates, textAlign: TextAlign.center)
          ],
        )
      ),
    );
  }

  void onTap() async{
    final Uri eventLink = Uri.parse(thisEvent.link);
    if (!await launchUrl(eventLink)) {
    throw Exception('Could not launch $eventLink');
    }
  }
}


