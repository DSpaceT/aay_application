import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


// utils/time_provider.dart


class TimerProvider with ChangeNotifier {
  late Timer _timer;
  int _seconds;
  bool _isPaused = false;
  late String userId;

  TimerProvider(this._seconds) {
    _timer = Timer.periodic(Duration(seconds: 1), _updateTimer);
  }
  bool pausedwhoknows(){
    if(_isPaused){
      return true;
    }else {
      return false;
    }
  }

  void _updateTimer(Timer timer) {
    if (!_isPaused && _seconds > 0) {
      _seconds--;
      notifyListeners();
    } else {
      _timer.cancel();
    }
  }

  int get seconds => _seconds;


  void pauseTimer() {
    _isPaused = true;
  }

  void resumeTimer() {
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

}
