import 'dart:async';
import 'package:flutter/foundation.dart';
import '../utils/device_id.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class PointsCounter with ChangeNotifier {
  late Timer _timer;
  int _seconds;
  bool _isPaused = false;
  late String userId; // User ID
  late int id;

  // Points-related fields
  int _points = 0;
  int get points => _points;

  PointsCounter(this._seconds) {
    _initializeData().then((_) {
      _initPointsIncrementTimer();
      _timer = Timer.periodic(Duration(seconds: 1), _updateTimer);
      _fetchInitialPoints();
    });

  }

  bool pausedwhoknows() {
    return _isPaused;
  }
  void setid(int id_place){
    id = id_place;
  }

  void _updateTimer(Timer timer) {
    if (!_isPaused && _seconds > 0) {
      _seconds--;
      notifyListeners();
    } else {
      _timer.cancel();
    }
  }

  // Function to initialize the points increment timer
  void _initPointsIncrementTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {//change to 10
      _incrementPoints();
    });
  }

  // Function to increment points
  void _incrementPoints() {
    if (!_isPaused) {
      _points += 1;
      print('Points incremented! Total Points: $_points');
      _updatePointsToFirestore(_points);
      // You can add additional logic here, e.g., notify listeners, update UI, etc.
    }
  }

  void pauseTimer() {
    _isPaused = true;
  }

  void resumeTimer() {
    _fetchInitialPoints();
    _isPaused = false;
    _timer.cancel(); // Cancel the existing timer
    _timer = Timer.periodic(Duration(seconds: 1), _updateTimer); // Start a new timer
    notifyListeners();
  }

  void setSeconds(int seconds) {
    _seconds = seconds;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> _updatePointsToFirestore(int points) async {
    if (userId.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({
            'points':points,
          })
          .catchError((error) {
            // Handle any errors here
            print('Error adding task to Firestore: $error');
          });
    }
  }
  Future<void> _initializeData() async {
    userId = await DeviceUtils.getDeviceId();
  }

  Future<void> _fetchInitialPoints() async {
    if (userId.isNotEmpty) {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userSnapshot.exists) {
        Map<String, dynamic>? userData = userSnapshot.data() as Map<String, dynamic>?;

        if (userData != null && userData.containsKey('points')) {
          // Field "points" exists, retrieve its value
          _points = userData['points'] ?? 0;
        } else {
          // Field "points" doesn't exist, create it with an initial value
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .update({'points': 0});
          _points = 0;
        }

        notifyListeners();
      }
    }
  }


}