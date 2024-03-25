

class Event{
  String name= "";
  String dates= "";
  String address= "";
  String link= "";
  String thumbnail= "";


  Event(Map<String, dynamic> eventMap){
    Map<String, dynamic> dateInfo = eventMap["date"];
    List<dynamic> addressInfo = eventMap["address"];
    name=eventMap["title"].toString();
    dates= dateInfo["start_date"].toString() + ", " + dateInfo["when"].toString();
    address=eventMap["address"] = addressInfo[0] + ", " + addressInfo[1] ;
    link=eventMap["link"].toString();
    thumbnail=eventMap["thumbnail"].toString();

  }


  Event.empty();

}