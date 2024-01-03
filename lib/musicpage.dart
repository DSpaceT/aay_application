import 'package:flutter/material.dart';
import 'widgets/overlay_function.dart';
import 'widgets/custom_appbar.dart';

class MusicPage extends StatefulWidget {
  const MusicPage({Key? key}) : super(key: key);

  @override
  _MusicPageState createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
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
                  image: AssetImage('assets/MusicPage.png'),
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
                title: 'Music Page',
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
                overlayImage: 'assets/overlays/Music_info_overlay.png', // Change the overlay image
              ),
            ),
          ],
        ),
      ),
    );
  }

}
