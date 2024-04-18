
import 'package:flutter/cupertino.dart';

import '../main.dart';
import 'components/eventwidget.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<StatefulWidget> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    return Center(child:
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        EventWidget(eventList[2]),
        SizedBox(height:15),
        EventWidget(eventList[1]),
        SizedBox(height:15),
        EventWidget(eventList[0]),
      ],
    ));
  }

}