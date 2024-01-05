// tasks.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  String id;
  String title;
  String description;
  bool isCompleted; // Added isCompleted property

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
  });
}

class TasksList extends StatefulWidget {
  final List<Task> tasks;
  final Function()? infoCallback;
  final String userId;

  TasksList({
    required this.tasks,
    this.infoCallback,
    required this.userId,
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
          return Container(
            decoration: BoxDecoration(
              color: index % 2 == 0 ? Colors.blueAccent : Colors.greenAccent,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
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
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      // Handle delete task action
                      _deleteTask(widget.tasks[index]);
                    },
                  ),
                  Checkbox(
                    value: widget.tasks[index].isCompleted,
                    onChanged: (bool? value) async {
                      setState(() {
                        // Update the isCompleted property when the checkbox is pressed
                        widget.tasks[index].isCompleted = value ?? false;
                      });
                      await updateTaskInFirestore(widget.tasks[index]);
                    },
                  ),
                ],
              ),
            ),
          );

        } else {return Container();}
      },
    );
  }
  Future<void> updateTaskInFirestore(Task task) async {
    if (widget.userId.isNotEmpty) {
      final tasksCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .collection('tasks');

      final taskDocument = await tasksCollection
          .where('id', isEqualTo: task.id)
          .get()
          .then((querySnapshot) {
        return querySnapshot.docs.firstOrNull;
      });

      if (taskDocument != null) {
        // Document exists, update it
        await tasksCollection.doc(taskDocument.id).update({
          'isCompleted': task.isCompleted,
        });
      } else {
        // Document does not exist, handle the situation accordingly
        print('Document does not exist!');
        // You may choose to create the document or log the error.
      }
    }
  }
  void _deleteTask(Task task) async {
    print("Deleting task with ID: ${task.id}");
    if (widget.userId.isNotEmpty) {
      print("User ID is not empty. Proceeding with deletion.");
      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(widget.userId)
            .collection('tasks')
            .where('id', isEqualTo: task.id)  // Using where clause to filter by task ID
            .get()
            .then((querySnapshot) {
              querySnapshot.docs.forEach((doc) async {
                await doc.reference.delete();
                print("Deletion successful in Firestore for task ID: ${task.id}");
              });

              setState(() {
                // Remove the task from the local list
                widget.tasks.remove(task);
                print("Local list updated for task ID: ${task.id}");
              });
            });
      } catch (e) {
        print("Error during deletion: $e");
      }
    } else {
      print("User ID is empty. Deletion aborted.");
    }
  }




}


