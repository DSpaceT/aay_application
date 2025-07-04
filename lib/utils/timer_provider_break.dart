import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:vibration/vibration.dart';

// utils/time_provider.dart


class TimerProviderBreak with ChangeNotifier {
  late Timer _timer;
  int _seconds;
  bool _isPaused = false;
  bool vibrate = false;

  TimerProviderBreak(this._seconds) {
    _timer = Timer.periodic(Duration(seconds: 1), _updateTimer);
  }

  void _updateTimer(Timer timer) {
    if (!_isPaused && _seconds > 0) {
      _seconds--;
      if(_seconds == 0){
        vibrate = true;
      }
      notifyListeners();
    } else if(vibrate){
      Vibration.vibrate(duration: 1000);
      vibrate = false;
      _timer.cancel();
    }else{
      _timer.cancel();
    }
  }

  int get seconds => _seconds;
  bool pausedwhoknows(){
    if(_isPaused){
      return true;
    }else {
      return false;
    }
  }
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
