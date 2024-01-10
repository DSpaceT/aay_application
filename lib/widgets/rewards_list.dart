// tasks.dart

import 'package:flutter/material.dart';


class Reward extends StatefulWidget {
  final String name;
  final String imageAsset;
  
  const Reward({
    required this.name,
    required this.imageAsset,
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
        // Add your button click logic here
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



//   @override
//   Widget build(BuildContext context) {
// return Padding(
//   padding: EdgeInsets.only(top: 50,left:40), // Adjust the top padding as needed
//   child: Column(
//     children: [
//       for (int index = 0; index < widget.places.length; index++)
//         Column(
//           children: [
//             Container(
//               child: Row(
//                 children: [
//                   Container(
//                     width: 300,
//                     height: 100,
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                         image: AssetImage(widget.places[index].imageAsset),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 10),
//                   // Other widgets you want to add in the row
//                 ],
//               ),
//             ),
//             SizedBox(height: 10), // Adjust the height as needed for vertical spacing
//           ],
//         ),
//     ],
//   ),
// );

//   }
}
