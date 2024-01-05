// tasks_page.dart

import 'package:flutter/material.dart';
import 'widgets/tasks_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'utils/device_id.dart';
import 'widgets/overlay_function.dart';


class TasksPage extends StatefulWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  late String userId; // User ID
  bool isOverlayVisible = false;
  final _controller = TextEditingController();
  final _controller2 = TextEditingController();

  late List<Task> tasks;

  void showOverlay_here() {
    setState(() {
      isOverlayVisible = true;
    });
  }

  void hideOverlay_here() {
    setState(() {
      isOverlayVisible = false;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initializeData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return _buildContent();
        } else {
          return CircularProgressIndicator(); // Loading indicator
        }
      },
    );
  }

  Future<void> _initializeData() async {
    userId = await DeviceUtils.getDeviceId();
    tasks = await _getAllTasksFromFirestore();
  }

  Widget _buildContent() {
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
            Positioned(
              top: 100,
              left: 20,
              right: 20,
              bottom: 200,
              child: TasksList(
                tasks: tasks,
                infoCallback: () => showOverlay_here(),
              ),
            ),
            Positioned(
              top: 580,
              left: 20,
              right: 20,
              bottom: 170,
              child: ElevatedButton(
                  onPressed: () {
                    // Open overlay when the "Add Task" button is pressed
                   showOverlay_here();
                  },
                  child: const Text('Add Task'),
                )
            ),
            Visibility(
              visible: isOverlayVisible,
              child: DialogBox(
                controller: _controller,
                controller2: _controller2,
                onSave: () => _addTask(_controller.text, _controller2.text),
                onCancel: hideOverlay_here,
                onClose: hideOverlay_here,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToBackPage(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _addTask(String newtitle, String newdescription) async {
    await _addTaskToFirestore(newtitle, newdescription);
    tasks = await _getAllTasksFromFirestore(); // Reload tasks after adding a new task
    setState(() {});
  }

  Future<void> _addTaskToFirestore(String newtitle, String newdescription) async {
    if (userId.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .add({
            'title': newtitle,
            'description': newdescription,
          });
    }
  }

  Future<List<Task>> _getAllTasksFromFirestore() async {
    List<Task> fetchedTasks = [];

    if (userId.isNotEmpty) {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .get();

      fetchedTasks = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        return Task(
          title: data['title'] ?? '',
          description: data['description'] ?? '',
        );
      }).toList();
    }

    return fetchedTasks;
  }
}
