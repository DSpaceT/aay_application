import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final bool showSettings;
  final bool showProfile;
  final bool showInfo;
  final Function()? infoCallback;

  CustomAppBar({
    Key? key,
    this.showSettings = true,
    this.showProfile = true,
    this.showInfo = true,
    this.infoCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Calculate the app bar height based on the device's screen height
    double screenHeight = MediaQuery.of(context).size.height;

    // Calculate the app bar height as 0.2 of the screen height
    double appBarHeight = screenHeight * 0.1;

    return Container(
      height: appBarHeight,
      child: AppBar(
        backgroundColor: Color.fromARGB(94, 92, 32, 233),
        elevation: 20,
        actions: [
          if (showSettings)
            IconButton(
              icon: Image.asset('assets/settings_icon.png'),
              onPressed: () {
                // Default onPressed functionality for settings button
                Navigator.pushNamed(context, '/settingspage');
              },
            ),
          if (showProfile)
            IconButton(
              icon: Image.asset('assets/account_circle_icon.png'),
              onPressed: () {
                // Default onPressed functionality for profile button
                Navigator.pushNamed(context, '/profilepage');
              },
            ),
          if (showInfo)
            IconButton(
              icon: Image.asset('assets/info_icon.png'),
              onPressed: () {
                // Call the custom infoCallback function if provided
                if (infoCallback != null) {
                  infoCallback!();
                } else {
                  // Default onPressed functionality for info button
                  Navigator.pushNamed(context, '/infopage');
                }
              },
            ),
          // Add more IconButton widgets as needed for additional buttons
        ],
      ),
    );
  }
}
