
import 'package:flutter/material.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onVerticalDragUpdate: (DragUpdateDetails details) {
        if (details.primaryDelta! > 0) {
          _navigateToBackPage(context);
        }
        
      },
      child :Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/TasksPage.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          //add other things here......
          ],
        ),
      );
    
  }
  void _navigateToBackPage(BuildContext context) {
    // Use Navigator to pop the current route and navigate back
    Navigator.of(context).pop();
  }
  
}
