import 'package:flutter/material.dart';

void showOverlay(BuildContext context, String overlayImage) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return InfoOverlay(
        onClose: () {
          Navigator.pop(context); // Close the overlay
        },
        overlayImage: overlayImage,
      );
    },
  );
}

class InfoOverlay extends StatelessWidget {
  final Function() onClose;
  final String overlayImage;

  InfoOverlay({required this.onClose, required this.overlayImage});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClose,
      child: Container(
        color: Colors.black.withOpacity(0.5),
        child: Center(
          child: Image.asset(
            overlayImage,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
