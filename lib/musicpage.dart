import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'widgets/custom_appbar.dart';

class MusicPage extends StatelessWidget {
  final AudioCache audioCache;

  // Factory constructor to initialize audioCache
  factory MusicPage() {
    return MusicPage._(AudioCache());
  }

  // Private named constructor for initialization
  MusicPage._(this.audioCache);

  void _playAudio(String audioFileName) {
    audioCache.play('../assets/audio/$audioFileName.mp3');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/MusicPage.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CustomAppBar(
              title: 'Profile Page',
              showSettings: true,
              showProfile: false,
              showInfo: true,
              //infoCallback: showOverlay,
              // You can add other properties/callbacks as needed
            ),
          ),
          Positioned(
            top: 100,
            child:ElevatedButton(
              onPressed: () => _playAudio('Music_is_Love'),
              child: Text('Play Audio 1'),
            ),
          ),
          // Positioned(
          //   top:200,
          //   child:ElevatedButton(
          //     onPressed: () => _playAudio('audio_file2'),
          //     child: Text('Play Audio 2'),
          //   ),
          // ),
          // Positioned(
          //   top:300,
          //   child:ElevatedButton(
          //     onPressed: () => _playAudio('audio_file3'),
          //     child: Text('Play Audio 3'),
          //   ),
          // ),
          ],
        ));
  }
}


// import 'package:flutter/material.dart';
// import 'widgets/overlay_function.dart';
// import 'widgets/custom_appbar.dart';

// class MusicPage extends StatefulWidget {
//   const MusicPage({Key? key}) : super(key: key);

//   @override
//   _MusicPageState createState() => _MusicPageState();
// }

// class _MusicPageState extends State<MusicPage> {
//   bool isOverlayVisible = false;

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
//     return GestureDetector(
//       onHorizontalDragUpdate: (DragUpdateDetails details) {
//         // Handle horizontal drag updates if needed
//       },
//       child: Scaffold(
//         body: Stack(
//           children: [
//             // Background Image
//             Container(
//               decoration: const BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage('assets/MusicPage.png'),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             // CustomAppBar
//             Positioned(
//               top: 0,
//               left: 0,
//               right: 0,
//               child: CustomAppBar(
//                 title: 'Music Page',
//                 showSettings: false,
//                 showProfile: true,
//                 showInfo: true,
//                 infoCallback: showOverlay,
//               ),
//             ),
//             // Overlay
//             Visibility(
//               visible: isOverlayVisible,
//               child: InfoOverlay(
//                 onClose: hideOverlay,
//                 overlayImage: 'assets/overlays/Music_info_overlay.png', // Change the overlay image
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

// }
