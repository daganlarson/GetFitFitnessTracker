
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:binarybrigade/models/event.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:binarybrigade/models/firestore.dart';
import 'package:binarybrigade/views/notifications.dart';

class EventWidget extends StatelessWidget {
  Event thisEvent;
  EventWidget(Event myEvent, {super.key}) : thisEvent = myEvent;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 250,
        width: 350,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Flexible(
          child: Column(
            children: [
            Align(
              alignment: Alignment.topLeft,
            child:ElevatedButton.icon(onPressed: onSave, style: ElevatedButton.styleFrom(shape: StarBorder(), alignment: Alignment.bottomLeft), icon: Icon(null), label: Text(""))
            ),
            Text(thisEvent.name),
            Image.network(thisEvent.thumbnail),
          Text(thisEvent.address + "\n" + thisEvent.dates.month.toString() + "/" + thisEvent.dates.day.toString() + "/"+thisEvent.dates.year.toString()+" " + thisEvent.dateSpan, textAlign: TextAlign.center)
          ],
          )
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
  void onSave(){
    Database.saveEvent(thisEvent);
    int length = thisEvent.dates.millisecondsSinceEpoch-DateTime.now().millisecondsSinceEpoch - 86400000;
    Notifications.scheduleEvent(title: thisEvent.name +" is soon!", message: "An event you were interested is happening tomorrow! Don't forget!", length: length);


  }
}




