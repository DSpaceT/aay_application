// tasks_page.dart

import 'package:flutter/material.dart';
import 'widgets/tasks_list.dart'; // Import the tasks.dart file

class TasksPage extends StatelessWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dummy tasks for demonstration purposes
    List<Task> tasks = [
      Task(title: 'Task 1', description: 'Description for Task 1'),
      Task(title: 'Task 2', description: 'Description for Task 2'),
      // Add more tasks as needed
    ];

    return Scaffold(
      body: GestureDetector(
        onVerticalDragUpdate: (DragUpdateDetails details) {
          if (details.primaryDelta! > 0) {
            _navigateToBackPage(context);
          }
        },
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/TasksPage.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Tasks List
            Positioned(
              top: 100, // Adjust the position as needed
              left: 20, // Adjust the position as needed
              right: 20, // Adjust the position as needed
              bottom: 20, // Adjust the position as needed
              child: TasksList(tasks: tasks),
            ),
            // Add other widgets as needed...
          ],
        ),
      ),
    );
  }

  void _navigateToBackPage(BuildContext context) {
    Navigator.of(context).pop();
  }
}
