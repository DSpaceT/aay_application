// tasks.dart

import 'package:flutter/material.dart';


class Task {
  String title;
  String description;

  Task({required this.title, required this.description});
}

class TasksList extends StatefulWidget {
  final List<Task> tasks;
  final Function()? infoCallback;

  TasksList({
    required this.tasks,
    this.infoCallback,
  });

  @override
  _TasksListState createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.tasks.length + 1, // Add 1 for the "Add Task" button
      itemBuilder: (context, index) {
        if (index < widget.tasks.length) {
          return ListTile(
            title: Text(
              widget.tasks[index].title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              widget.tasks[index].description,
              style: const TextStyle(fontSize: 16),
            ),
          );
        } 
        // else {
        //   // "Add Task" button
        //   return ElevatedButton(
        //     onPressed: () {
        //       // Open overlay when the "Add Task" button is pressed
        //       if (widget.infoCallback != null) {
        //         widget.infoCallback!();
        //       }
        //     },
        //     child: const Text('Add Task'),
        //   );
        // }
      },
    );
  }
}


