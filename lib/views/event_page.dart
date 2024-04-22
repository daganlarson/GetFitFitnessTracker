
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
    ListView(
      children: List.generate(3, (index) => EventWidget(eventList[index])),
    )
    );
  }

}