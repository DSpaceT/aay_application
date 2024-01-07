import 'package:flutter/material.dart';
import 'widgets/overlay_function.dart';
import 'widgets/custom_appbar.dart';

class PlacesPage extends StatefulWidget {
  const PlacesPage({Key? key}) : super(key: key);

  @override
  _PlacesPageState createState() => _PlacesPageState();
}

class _PlacesPageState extends State<PlacesPage> {
  bool isOverlayVisible = false;
  bool isCheckboxSelected = false;

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

  void onCheckboxValueChanged(bool? value) {
    if (value != null) {
      setState(() {
        isCheckboxSelected = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (DragUpdateDetails details) {
        // Handle horizontal drag updates if needed
      },
      child: Scaffold(
        body: Stack(
          children: [
            // Background Image
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/PlacesPage.png'),
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
                title: 'Places Page',
                showSettings: false,
                showProfile: true,
                showInfo: true,
                infoCallback: showOverlay,
              ),
            ),
            // Overlay
            Visibility(
              visible: isOverlayVisible,
              child: InfoOverlay(
                onClose: hideOverlay,
                overlayImage: 'assets/overlays/Places_info_overlay.png',
              ),
            ),
            // Image and Checkbox
            Positioned(
              top: 190,
              left: 0,
              child: Row(
                children: [
                  // Your Image widget here
                  Image.asset(
                    'assets/places/Starbucks_place.png',
                    width: 300,
                    height: 130,
                  ),
                  SizedBox(width: 10),
                  // Your Checkbox widget here
                  Checkbox(
                    value: isCheckboxSelected,
                    onChanged: onCheckboxValueChanged,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'widgets/overlay_function.dart';
// import 'widgets/custom_appbar.dart';

// class PlacesPage extends StatefulWidget {
//   const PlacesPage({Key? key}) : super(key: key);

//   @override
//   _PlacesPageState createState() => _PlacesPageState();
// }

// class _PlacesPageState extends State<PlacesPage> {
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
//                   image: AssetImage('assets/PlacesPage.png'),
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
//                 title: 'Places Page',
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
//                 overlayImage: 'assets/overlays/Places_info_overlay.png', // Change the overlay image
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

// }
