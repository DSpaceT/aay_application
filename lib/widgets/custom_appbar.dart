import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final bool showSettings;
  final bool showProfile;
  final bool showInfo;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.showSettings = true,
    this.showProfile = true,
    this.showInfo = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      backgroundColor: Colors.transparent,
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
              // Default onPressed functionality for profile button
              Navigator.pushNamed(context, '/infopage');
            },
          ),
        // Add more IconButton widgets as needed for additional buttons
      ],
    );
  }
}
