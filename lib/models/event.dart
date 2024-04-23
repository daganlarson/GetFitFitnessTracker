import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  String name = "";
  DateTime dates = DateTime.timestamp();
  String dateSpan ="";
  String address = "";
  String link = "";
  String thumbnail = "";


  Event(Map<String, dynamic> eventMap) {
    Map<String, dynamic> dateInfo = eventMap["date"];
    List<dynamic> addressInfo = eventMap["address"];
    name = eventMap["title"].toString();
    int dayOfWeek=int.parse(dateInfo["start_date"].toString().split(' ')[1]);
    int month = getMonthNum(dateInfo['start_date'].toString().split(' ')[0]);
    dates= DateTime(DateTime.now().year, month, dayOfWeek);
    dateSpan= dateInfo["when"].toString();
    address = eventMap["address"] = addressInfo[0] + ", " + addressInfo[1];
    link = eventMap["link"].toString();
    thumbnail = eventMap["thumbnail"].toString();
  }

  Event.fireStoreConstructor(String f_name, DateTime f_dates, String f_dateSpan, String f_address, String f_link, String f_thumbnail){
      name=f_name;
      dates=f_dates;
      dateSpan=f_dateSpan;
      address=f_address;
      link = f_link;
      thumbnail= f_thumbnail;
  }


  Event.empty();


  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'date': dates,
      'dateSpan':dateSpan,
      'location':address,
      'link': link,
      'image':thumbnail
    };
  }

  factory Event.fromFireStore(DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options,) {
    final data = snapshot.data();
    return Event.fireStoreConstructor(data?['name'],
        data?['date'],
        data?['dateSpan'],
        data?['location'],
        data?['link'],
        data?['imgae']);
  }

  int getMonthNum(String monthStart){
    switch(monthStart){
      case 'Jan':
        return DateTime.january;
      case 'Feb':
        return DateTime.february;
      case 'Mar':
        return DateTime.march;
      case 'Apr':
        return DateTime.april;
      case 'May':
        return DateTime.may;
      case 'Jun':
        return DateTime.june;
      case 'Jul':
        return DateTime.july;
      case 'Aug':
        return DateTime.august;
      case 'Sep':
        return DateTime.september;
      case 'Oct':
        return DateTime.october;
      case 'Nov':
        return DateTime.november;
      case 'Dec':
        return DateTime.december;
    }
    return 0;
  }
}