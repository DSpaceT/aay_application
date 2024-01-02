
import 'package:flutter/material.dart';

class MusicPage extends StatelessWidget {
  const MusicPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onHorizontalDragUpdate: (DragUpdateDetails details) {
        
      },
      child :Scaffold(
        appBar: AppBar(
          title: const Text('MusicPage'),
          ),
      
        body : Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/MusicPage.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          //add other things here......
          ],
        ),
      ),
    );
  }

  
}
