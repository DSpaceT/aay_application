import 'package:flutter/material.dart';
import 'widgets/overlay_function.dart';
import 'widgets/custom_appbar.dart';
import 'package:app_settings/app_settings.dart';
import 'package:android_intent/android_intent.dart';


class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isOverlayVisible = false;
  bool suppressNotifications = false;
  bool suppressPhoneCalls = false;

  void showOverlay() {
    setState(() {
      isOverlayVisible = true;
    });
  }
  void onPressed() {
    AppSettings.openAppSettings();
    // or whatever settings you want to open
  }
  void openDeviceSettings() {
  AndroidIntent intent = AndroidIntent(
    action: "android.settings.APPLICATION_DETAILS_SETTINGS",
    package: "com.example.aay_application",
    data: "package:com.example.aay_application",
  );
  intent.launch();
  }


  void hideOverlay() {
    setState(() {
      isOverlayVisible = false;
    });
  }

  void toggleSuppressNotifications() {
    setState(() {
      suppressNotifications = !suppressNotifications;
    });
    // Add logic to handle suppressing notifications
    // You might want to call a method or set a value in a provider here
  }

  void toggleSuppressPhoneCalls() {
    setState(() {
      suppressPhoneCalls = !suppressPhoneCalls;
    });
    // Add logic to handle suppressing phone calls
    // You might want to call a method or set a value in a provider here
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
                  image: AssetImage('assets/SettingsPage.png'),
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
                title: 'Settings Page',
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
                overlayImage: 'assets/overlays/Settings_info_overlay.png', // Change the overlay image
              ),
            ),

            Positioned(
              top: 206,
              left: 30,
              right: 190,
              height:35,
              child:Container(
                color: Colors.blueGrey,
                child:const Center(
                  child:Text(
                    'Phone Calls',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ),
              ),
            ),
            Positioned(
              top: 206,
              width: 80,
              height: 35,
              left :250,
              child: ElevatedButton(
                onPressed:toggleSuppressPhoneCalls,
                child: Container(),
              ),
            ),
AnimatedPositioned(
      duration: Duration(milliseconds: 300),
      top: 209,
      left: suppressPhoneCalls ? 297.0 : 255.0,
      child: GestureDetector(
        onTap: () {
          // Handle the tap here, e.g., toggle suppressPhoneCalls
          //toggleSuppressPhoneCalls();
        },
        child: Container(
          width: 30.0,
          height: 30.0,
          decoration: BoxDecoration(
            color: Colors.white, // Set the background color to transparent
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Center(
            child: Icon(
              Icons.circle,
              color: suppressPhoneCalls ? Colors.green : Colors.red,
            ),
          ),
        ),
      ),
    ),
        
          ],
        ),
      ),
    );
  }
}


