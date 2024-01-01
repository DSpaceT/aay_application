
import 'package:flutter/material.dart';

class StudyPage extends StatelessWidget {
  const StudyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onHorizontalDragUpdate: (DragUpdateDetails details) {
        
      },
      child :Scaffold(
        appBar: AppBar(
          title: const Text('StudyPage'),
          ),
      
        body : Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/StudyPage.png'),
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
