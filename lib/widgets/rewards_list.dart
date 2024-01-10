

// tasks.dart

import 'package:flutter/material.dart';
import '../profilepage.dart';

class Reward extends StatefulWidget {
  final String name;
  final String imageAsset;
  final Function(int) onButtonPressed;
  final int index;
  
  const Reward({
    required this.name,
    required this.imageAsset,
    required this.onButtonPressed,
    required this.index,
  });

  @override
  State<Reward> createState() => _RewardState();
}

class _RewardState extends State<Reward> {
  @override
Widget build(BuildContext context) {
  return ListTile(
    title: ElevatedButton(
      onPressed: () {
        print("wtf");
        widget.onButtonPressed(widget.index);
        print("executed");
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.transparent, // Set the button background color to transparent
        elevation: 0,
        fixedSize: const Size(50, 100), // Remove the button elevation
      ),
      child: Ink.image(
        image: AssetImage(widget.imageAsset),
        fit: BoxFit.cover,
      ),
    ),

  );
  
}

}
