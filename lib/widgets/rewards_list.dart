import 'package:flutter/material.dart';

class Reward extends StatefulWidget {
  final String name;
  final String imageAsset;
  final Function(Reward) onButtonPressed;
  final int index;
  final String text;
  final String code;
  final int cost;

  const Reward({
    required this.code,
    required this.text,
    required this.name,
    required this.imageAsset,
    required this.onButtonPressed,
    required this.index,
    required this.cost,
  });

  @override
  State<Reward> createState() => _RewardState();
}

class _RewardState extends State<Reward> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: InkWell(
        onTap: () {
          print("wtf");
          widget.onButtonPressed(widget);
          print("executed");
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Call the onButtonPressed callback directly
                widget.onButtonPressed(widget);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                elevation: 0,
                fixedSize: const Size(500, 100),
              ),
              child: Ink.image(
                image: AssetImage(widget.imageAsset),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.04,
              left: MediaQuery.of(context).size.width * 0.33,
              child: Text(
                widget.text,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



// // tasks.dart

// import 'package:flutter/material.dart';


// class Reward extends StatefulWidget {
//   final String name;
//   final String imageAsset;
//   final Function(int) onButtonPressed;
//   final int index;
//   final String text;
  
//   const Reward({
//     required this.text,
//     required this.name,
//     required this.imageAsset,
//     required this.onButtonPressed,
//     required this.index,
//   });

//   @override
//   State<Reward> createState() => _RewardState();
// }

// class _RewardState extends State<Reward> {
//   @override
// Widget build(BuildContext context) {
//   return ListTile(
//     title: ElevatedButton(
//       onPressed: () {
//         print("wtf");
//         widget.onButtonPressed(widget.index);
//         print("executed");
//       },
//       style: ElevatedButton.styleFrom(
//         primary: Colors.transparent, // Set the button background color to transparent
//         elevation: 0,
//         fixedSize: const Size(50, 100), // Remove the button elevation
//       ),
//       child: Ink.image(
//         image: AssetImage(widget.imageAsset),
//         fit: BoxFit.cover,
//       ),
//     ),

//   );
  
// }

// }
