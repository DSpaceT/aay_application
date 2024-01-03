// tasks.dart

import 'package:flutter/material.dart';

class Task {
  String title;
  String description;

  Task({required this.title, required this.description});
}

class TasksList extends StatefulWidget {
  final List<Task> tasks;

  TasksList({required this.tasks});

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
            title: TextField(
              controller: TextEditingController(text: widget.tasks[index].title),
              onChanged: (text) {
                widget.tasks[index].title = text;
              },
              decoration: InputDecoration(
                labelText: 'Task Title',
              ),
            ),
            subtitle: TextField(
              controller: TextEditingController(text: widget.tasks[index].description),
              onChanged: (text) {
                widget.tasks[index].description = text;
              },
              decoration: InputDecoration(
                labelText: 'Task Description',
              ),
            ),
          );
        } else {
          // "Add Task" button
          return ElevatedButton(
            onPressed: () {
              setState(() {
                // Add a new task to the list
                widget.tasks.add(Task(title: 'New Task', description: ''));
              });
            },
            child: Text('Add Task'),
          );
        }
      },
    );
  }
}

