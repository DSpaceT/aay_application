import 'package:flutter/material.dart';
import 'widgets/overlay_function.dart';
import 'widgets/custom_appbar.dart';
import 'widgets/schedule_adder.dart';

import 'package:provider/provider.dart';

import 'utils/time_provider.dart';
import 'utils/timer_provider_break.dart';

import 'package:vibration/vibration.dart';

bool globalstudy = true;
bool globalresume = false;

class StudyPage extends StatefulWidget {
  const StudyPage({Key? key}) : super(key: key);

  @override
  _StudyPageState createState() => _StudyPageState();
}

class _StudyPageState extends State<StudyPage> {
  bool isOverlayVisible = false;
  bool isOverlayVisible2 = false;
  bool study = globalstudy;
  bool resumed = globalresume;
  int selectedMinutes = 0;
  bool shouldVibrate = false;

  int firstbox = 10;
  int secondbox = 30;
  int thirdbox = 45;

  void showOverlay() {
    setState(() {
      isOverlayVisible = true;
    });
  }

  void hideOverlay() {
    setState(() {
      isOverlayVisible = false;
    });
  }

  void showOverlay_here() {
    setState(() {
      isOverlayVisible2 = true;
    });
  }

  void hideOverlay_here() {
    setState(() {
      isOverlayVisible2 = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var timerProvider = Provider.of<TimerProvider>(context);
    var timerProviderBreak = Provider.of<TimerProviderBreak>(context);

    return GestureDetector(
      onHorizontalDragUpdate: (DragUpdateDetails details) {
        if (details.primaryDelta! > 0) {
          _navigateToTasksPage(context);
        }
      },
      onTapUp: (TapUpDetails details) {
        // Get the position of the tap
        double tapPosition = details.globalPosition.dy;

        // Get the screen height
        double screenHeight = MediaQuery.of(context).size.height;

        // Calculate the threshold for the bottom 1/7 of the screen
        double bottomThreshold = screenHeight * (6 / 7);

        // Check if the tap is in the bottom 1/7 of the screen
        if (tapPosition > bottomThreshold) {
          // Call the function for the bottom 1/7 of the screen
          _navigateToMusicPage(context);
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/StudyPage.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // CustomAppBar
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: CustomAppBar(
                showSettings: true,
                showProfile: true,
                showInfo: true,
                infoCallback: showOverlay,
              ),
            ),
            // Countdown Clock (Centered and Bigger)
            Positioned(
                top: MediaQuery.of(context).size.height * 0.35,
                left: () {
                  var what;
                  if (study) {
                    what = timerProvider.seconds;
                  } else {
                    what = timerProviderBreak.seconds;
                  }
                  if (what == 0 && shouldVibrate) {
                    resumed = false;
                    globalresume = false;
                    Vibration.vibrate(duration: 1000);
                    setState(() {
                      shouldVibrate = false;
                    });
                  }
                  if (what >= 600) {
                    return MediaQuery.of(context).size.width / 2 -
                        (87 / 70) * MediaQuery.of(context).size.width / 5;
                  } else {
                    return MediaQuery.of(context).size.width / 2 -
                        (65 / 70) * MediaQuery.of(context).size.width / 5;
                  }
                }(),
                child: study
                    ? Text(
                        _formatCountdown(timerProvider.seconds),
                        style: TextStyle(
                          foreground: Paint()
                            ..shader = const LinearGradient(
                              colors: [
                                Color.fromARGB(255, 0, 255, 179),
                                Color.fromARGB(255, 0, 255, 191),
                                Color.fromARGB(255, 0, 174, 243),
                              ],
                            ).createShader(const Rect.fromLTWH(
                                100.0, 200.0, 200.0, 100.0)),
                          fontSize: MediaQuery.of(context).size.width / 5,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : Text(
                        _formatCountdown(timerProviderBreak.seconds),
                        style: TextStyle(
                          foreground: Paint()
                            ..shader = const LinearGradient(
                              colors: [
                                Color.fromARGB(255, 0, 255, 179),
                                Color.fromARGB(255, 0, 255, 191),
                                Color.fromARGB(255, 0, 174, 243),
                              ],
                            ).createShader(const Rect.fromLTWH(
                                100.0, 200.0, 200.0, 100.0)),
                          fontSize: MediaQuery.of(context).size.width / 5,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
            Positioned(
                top: MediaQuery.of(context).size.width * 0.43,
                left: MediaQuery.of(context).size.width * 0.22,
                child: Container(
                    //color: Color.fromARGB(255, 50, 210, 228), // Set the background color here
                    padding: EdgeInsets.all(13.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          10.0), // Adjust the border radius
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color.fromARGB(255, 158, 59, 173).withOpacity(0.1),
                          Color.fromARGB(255, 44, 88, 185).withOpacity(0.2)
                        ],
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(
                              255, 50, 210, 228), // Adjust the shadow color
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: Offset(0, 3), // Adjust the shadow offset
                        ),
                      ],
                    ),
                    child: study
                        ? const Text(
                            "Study Session",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : const Text(
                            "Break Session",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ))),
            // ... existing code ...

            // Pause Button
            Positioned(
              top: MediaQuery.of(context).size.height * 0.58,
              left: MediaQuery.of(context).size.width * 0.39,
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      shouldVibrate = true;
                      if (resumed) {
                        resumed = false;
                        globalresume = false;
                        if (study) {
                          timerProvider.pauseTimer();
                        } else {
                          timerProviderBreak.pauseTimer();
                        }
                      } else {
                        resumed = true;
                        globalresume = true;
                        if (study) {
                          timerProvider.resumeTimer();
                        } else {
                          timerProviderBreak.resumeTimer();
                        }
                      }
                    });
                  },
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(16),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 154, 25, 177))),
                  child: Center(
                      child: resumed
                          ? const Center(
                              child: Icon(
                                Icons.pause,
                                size: 50,
                                color: Color.fromARGB(255, 90, 255, 205),
                              ),
                            )
                          : const Center(
                              child: Icon(
                                Icons.play_arrow,
                                size: 50,
                                color: Color.fromARGB(255, 90, 255, 205),
                              ),
                            ))),
            ),

            // Set 5 Minutes Button
            Positioned(
              top: MediaQuery.of(context).size.height * 0.13,
              left: MediaQuery.of(context).size.width / 9,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (study) {
                      timerProvider.setSeconds(firstbox * 60);
                    } else {
                      timerProviderBreak.setSeconds(firstbox * 60);
                    }
                  });
                },
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all(16),
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(16)),
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 154, 25, 177))),
                child: Text(
                  '${firstbox}m',
                  style: const TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.13,
              left: MediaQuery.of(context).size.width / 3,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (study) {
                      timerProvider.setSeconds(secondbox * 60);
                    } else {
                      timerProviderBreak.setSeconds(secondbox * 60);
                    }
                  });
                },
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all(16),
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(16)),
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 154, 25, 177))),
                child: Text(
                  '${secondbox}m',
                  style: const TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.13,
              left: MediaQuery.of(context).size.width * 5 / 9,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (study) {
                      timerProvider.setSeconds(thirdbox * 60);
                    } else {
                      timerProviderBreak.setSeconds(thirdbox * 60);
                    }
                  });
                },
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all(16),
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(16)),
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 154, 25, 177))),
                child: Text(
                  '${thirdbox}m',
                  style: const TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.66,
              left: MediaQuery.of(context).size.width * 0.39,
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      resumed = false;
                      globalresume = false;
                      if (study) {
                        timerProvider.pauseTimer();
                        study = false;
                        globalstudy = false;
                      } else {
                        timerProviderBreak.pauseTimer();
                        study = true;
                        globalstudy = true;
                      }
                    });
                  },
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(16),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 154, 25, 177))),
                  child: study
                      ? const Text(
                          'Break',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        )
                      : const Text(
                          'Study',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        )),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.13,
              left: MediaQuery.of(context).size.width * 7 / 9,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    isOverlayVisible2 = true;
                  });
                },
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all(16),
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(16)),
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 0, 153, 255))),
                child: const Text(
                  '>>',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            ),
            Positioned.fill(
              child: Visibility(
                visible: isOverlayVisible2,
                child: ScheduleAdder(
                  onSave: () => {
                    //hideOverlay_here(),
                    setState(() {
                      isOverlayVisible2 = false;
                      if (study) {
                        timerProvider.setSeconds(selectedMinutes * 60);
                      } else {
                        timerProviderBreak.setSeconds(selectedMinutes * 60);
                      }
                    }),
                  },
                  onCancel: hideOverlay_here,
                  onClose: hideOverlay_here,
                  onMinutesSelected: (minutes) {
                    setState(() {
                      selectedMinutes = minutes;
                    });
                  },
                ),
              ),
            ),
            Positioned.fill(
              child: Visibility(
                visible: isOverlayVisible,
                child: InfoOverlay(
                  onClose: hideOverlay,
                  overlayImage: 'assets/overlays/Study_info_overlay.png',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatCountdown(int countdownSeconds) {
    int minutes = countdownSeconds ~/ 60;
    int seconds = countdownSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  void _navigateToTasksPage(BuildContext context) {
    Navigator.pushNamed(context, '/taskspage');
  }

  void _navigateToMusicPage(BuildContext context) {
    Navigator.pushNamed(context, '/musicpage');
  }

  // ... rest of the class remains unchanged ...
}
