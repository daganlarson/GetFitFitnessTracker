import 'dart:convert';
import 'dart:io';

List<String> readStringListFromJsonSync() {
    File file = File('lib/views/components/youtube_player/videoList.json');
    String contents = file.readAsStringSync();
    List<dynamic> decodedList = json.decode(contents);
    List<String> stringList = List<String>.from(decodedList);
    return stringList;
}

void writeStringToJsonFile(String data) {
        dynamic jsonData = data;
        String jsonString = json.encode(jsonData);
        File file = File('lib/views/components/youtube_player/videoList.json');
        file.writeAsStringSync(jsonString);

}
void main() {
}
