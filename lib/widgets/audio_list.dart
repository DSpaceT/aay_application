import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioItem extends StatefulWidget {
  final AudioPlayer player;
  final String assettoplay;
  final VoidCallback onPressed;

  const AudioItem({
    required this.player,
    required this.assettoplay,
    required this.onPressed,
  });

  @override
  State<AudioItem> createState() => _AudioItemState();
}

class _AudioItemState extends State<AudioItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: ElevatedButton(
        onPressed: () {
          widget.onPressed();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 141, 69, 170),
          minimumSize: Size(100, 50),
        ),
        child: Text(
          widget.assettoplay, // Change label dynamically
          style: TextStyle(fontSize: 18, color: Colors.amber),
        ),
      ),
    );
  }
}
