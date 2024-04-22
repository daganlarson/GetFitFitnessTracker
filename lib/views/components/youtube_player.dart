import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

void main() {
  runApp(Youtube());
}

class Youtube extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Video',
      home: Youtube_Player(),
    );
  }
}

class Youtube_Player extends StatelessWidget {
  static String myVideoId = 'ApXoWvfEYVU';
  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: myVideoId,
    flags: YoutubePlayerFlags(
      autoPlay: true,
      mute: false,
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Watch this'),
        ),
        body: Container(
          child: YoutubePlayer(
            controller: _controller,
            liveUIColor: Colors.amber,
          ),
        ));
  }
}