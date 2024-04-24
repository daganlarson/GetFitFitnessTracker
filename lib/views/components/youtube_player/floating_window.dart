import 'package:flutter/material.dart';

class FloatingVideoPlayer extends StatefulWidget {
  @override
  FloatingVideoPlayerState createState() => FloatingVideoPlayerState();
}
class FloatingVideoPlayerState extends State<FloatingVideoPlayer> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 100,
      left: 100,
      child: GestureDetector(
        // Implement drag functionality
        onPanUpdate: (details) {
          setState(() {
          });
        },
        child: Container(
          width: 200,
          height: 150,
          color: Colors.grey, // Adjust color as needed
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Floating Video Player'),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context); // Close the floating widget
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
