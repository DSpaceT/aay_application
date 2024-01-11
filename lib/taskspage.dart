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
  static int number = 0;
  bool isDataFetched = false;

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
    _initializeData();
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

  // Future<void> _initializeData() async {
  //   userId = await DeviceUtils.getDeviceId();
  //   tasks = await _getAllTasksFromFirestore();
  // }

  Widget _buildContent() {
    return Scaffold(
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
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
                userId: userId,
                tasks: tasks,
                infoCallback: () => showOverlay_here(),
              ),
            ),
            Positioned(
                top: 540,
                left: 165,
                right: 165,
                bottom: 280,
                child: FloatingActionButton(
                    backgroundColor: Colors.green,
                    onPressed: () {
                      // Open overlay when the "Add Task" button is pressed
                      showOverlay_here();
                    },
                    child: const Icon(Icons.add))),
            Visibility(
              visible: isOverlayVisible,
              child: DialogBox(
                controller: _controller,
                controller2: _controller2,
                onSave: () => {
                  //hideOverlay_here(),
                  isOverlayVisible = false,
                  _addTask(_controller.text, _controller2.text),
                  _controller.clear(),
                  _controller2.clear(),
                },
                onCancel: hideOverlay_here,
                onClose: hideOverlay_here,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _initializeData() async {
    userId = await DeviceUtils.getDeviceId();

    // Fetch data only if it hasn't been fetched already
    if (!isDataFetched) {
      tasks = await _getAllTasksFromFirestore();
      isDataFetched = true;
    }
  }

  void _navigateToBackPage(BuildContext context) {
    Navigator.pop(context);
  }

  void _addTask(String newtitle, String newdescription) async {
    await _addTaskToFirestore(newtitle, newdescription);
    //tasks = await _getAllTasksFromFirestore();
    // Reload tasks after adding a new task
    //setState(() {});
  }

  Future<void> _addTaskToFirestore(
      String newtitle, String newdescription) async {
    if (userId.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .add({
        'title': newtitle,
        'description': newdescription,
        'id': number.toString(),
        'isCompleted': false,
      }).then((documentReference) {
        // Successfully added to Firestore, update the local list
        Task newTask = Task(
          id: number.toString(),
          title: newtitle,
          description: newdescription,
          isCompleted: false,
        );
        tasks.add(newTask);
        setState(() {}); // Trigger a rebuild to update the UI
      }).catchError((error) {
        // Handle any errors here
        print('Error adding task to Firestore: $error');
      });
    }

    number++;
  }

  Future<List<Task>> _getAllTasksFromFirestore() async {
    print("getting data");
    List<Task> fetchedTasks = [];

    if (userId.isNotEmpty) {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .collection('tasks')
              .get();

      fetchedTasks = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        return Task(
          id: data['id'],
          title: data['title'] ?? '',
          description: data['description'] ?? '',
          isCompleted: data['isCompleted'],
        );
      }).toList();
    }

    return fetchedTasks;
  }
}
