import 'package:flutter/material.dart';
import 'widgets/overlay_function.dart';
import 'widgets/custom_appbar.dart';

import 'package:provider/provider.dart';

import 'dart:async';

import 'utils/time_provider.dart';


// Assuming the TimerProvider is in 'utils/time_provider.dart'
import 'utils/time_provider.dart';
class StudyPage extends StatefulWidget {
  const StudyPage({Key? key}) : super(key: key);

  @override
  _StudyPageState createState() => _StudyPageState();
}

class _StudyPageState extends State<StudyPage> {
  bool isOverlayVisible = false;

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

  @override
  Widget build(BuildContext context) {
    var timerProvider = Provider.of<TimerProvider>(context);
    
    return GestureDetector(
      onHorizontalDragUpdate: (DragUpdateDetails details) {
        if (details.primaryDelta! > 0) {
          _navigateToTasksPage(context);
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
                title: 'Another Page',
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
                if (timerProvider.seconds >= 600) {
                  return MediaQuery.of(context).size.width / 2 -
                      (87 / 70) * MediaQuery.of(context).size.width / 5;
                } else {
                  return MediaQuery.of(context).size.width / 2 -
                      (65 / 70) * MediaQuery.of(context).size.width / 5;
                }
              }(),
              child: Text(
                _formatCountdown(timerProvider.seconds),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.width / 5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // ... existing code ...

            // Pause Button
            Positioned(
              top: MediaQuery.of(context).size.height * 0.6,
              left: MediaQuery.of(context).size.width / 6,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    timerProvider.pauseTimer();
                  });
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(16),
                ),
                child: const Text(
                  ' Pause  ',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),

            // Resume Button
            Positioned(
              top: MediaQuery.of(context).size.height * 0.6,
              left: MediaQuery.of(context).size.width * 0.6,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    timerProvider.resumeTimer();
                  });
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(16),
                ),
                child: const Text(
                  'Resume',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),

            // Set 5 Minutes Button
            Positioned(
              top: MediaQuery.of(context).size.height * 0.7,
              left: MediaQuery.of(context).size.width / 3,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    
                    timerProvider.setSeconds(300);
                  });
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                ),
                child: const Text(
                  'Set 5 Minutes',
                  style: TextStyle(
                    fontSize: 20,
                  ),
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

  // ... rest of the class remains unchanged ...
}




// class StudyPage extends StatefulWidget {
//   const StudyPage({Key? key}) : super(key: key);

//   @override
//   _StudyPageState createState() => _StudyPageState();
// }

// class _StudyPageState extends State<StudyPage> {
//   bool isOverlayVisible = false;
//   bool isPaused = false;

//   void showOverlay() {
//     setState(() {
//       isOverlayVisible = true;
//     });
//   }

//   void hideOverlay() {
//     setState(() {
//       isOverlayVisible = false;
//     });
//   }


//   @override
//   Widget build(BuildContext context) {
//     var timerProvider = Provider.of<TimerProvider>(context);
//     return GestureDetector(
//       onHorizontalDragUpdate: (DragUpdateDetails details) {
//         if (details.primaryDelta! > 0) {
//           _navigateToTasksPage(context);
//         }
//       },
//       child: Scaffold(
//         body: Stack(
//           children: [
//             Container(
//               decoration: const BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage('assets/StudyPage.png'),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             // Overlay
//             Positioned.fill(
//               child: Visibility(
//                 visible: isOverlayVisible,
//                 child: InfoOverlay(
//                   onClose: hideOverlay,
//                   overlayImage: 'assets/overlays/Study_info_overlay.png',
//                 ),
//               ),
//             ),
//             // CustomAppBar
//             Positioned(
//               top: 0,
//               left: 0,
//               right: 0,
//               child: CustomAppBar(
//                 title: 'Another Page',
//                 showSettings: true,
//                 showProfile: true,
//                 showInfo: true,
//                 infoCallback: showOverlay,
//               ),
//             ),
//             // Countdown Clock (Centered and Bigger)
//             Positioned(
//               top: MediaQuery.of(context).size.height * 0.35,
//               left: () {
//                 if (timerProvider.seconds >= 600) {
//                   return MediaQuery.of(context).size.width / 2 -
//                       (87 / 70) * MediaQuery.of(context).size.width / 5;
//                 } else {
//                   return MediaQuery.of(context).size.width / 2 -
//                       (65 / 70) * MediaQuery.of(context).size.width / 5;
//                 }
//               }(),
//               child: Text(
//                 _formatCountdown(timerProvider.seconds),
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: MediaQuery.of(context).size.width / 5,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             // Pause Button
// // Pause Button
//             Positioned(
//               top: MediaQuery.of(context).size.height * 0.6,
//               left: MediaQuery.of(context).size.width / 6,
//               child: ElevatedButton(
//                 onPressed: () {
//                   setState(() {
//                     timerProvider.pauseTimer();
//                   });
//                 },
//                 style: ElevatedButton.styleFrom(
//                   padding: EdgeInsets.all(16), // Increase padding to make the button bigger
//                 ),
//                 child: Text(
//                   ' Pause  ',
//                   style: TextStyle(
//                     fontSize: 20, // Increase fontSize to make the text bigger
//                   ),
//                 ),
//               ),
//             ),

//             // Resume Button
//             Positioned(
//               top: MediaQuery.of(context).size.height * 0.6,
//               left: MediaQuery.of(context).size.width *0.6,
//               child: ElevatedButton(
//                 onPressed: () {
//                   setState(() {
//                     timerProvider.resumeTimer();
//                   });
//                 },
//                 style: ElevatedButton.styleFrom(
//                   padding: EdgeInsets.all(16), // Increase padding to make the button bigger
//                 ),
//                 child: Text(
//                   'Resume',
//                   style: TextStyle(
//                     fontSize: 20, // Increase fontSize to make the text bigger
//                   ),
//                 ),
//               ),
//             ),

//           ],
//         ),
//       ),
//     );
//   }

//   String _formatCountdown(int countdownSeconds) {
//     int minutes = countdownSeconds ~/ 60;
//     int seconds = countdownSeconds % 60;
//     return '$minutes:${seconds.toString().padLeft(2, '0')}';
//   }

//   void _navigateToTasksPage(BuildContext context) {
//     Navigator.pushNamed(context, '/taskspage');
//   }
// }

