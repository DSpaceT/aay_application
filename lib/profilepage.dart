import 'package:flutter/material.dart';
import 'widgets/custom_appbar.dart';
import 'utils/device_id.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'widgets/overlay_function.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String userId;
  late int points = 0; // Initialize with a default value
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
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initializeData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return _buildContent();
        } else {
          return CircularProgressIndicator(); // Loading indicator
        }
      },
    );
  }
 
  Widget _buildContent() {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/ProfilePage.png'),
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
              title: 'Profile Page',
              showSettings: true,
              showProfile: false,
              showInfo: true,
              infoCallback: showOverlay,
              // You can add other properties/callbacks as needed
            ),
          ),
          // Your ProfilePage content goes here
          // For example, you can add two containers with images and text in the center:
          Center(
            child: Stack(
              children: [
                // First container
                Positioned(
                  top: MediaQuery.of(context).size.height*0.27,
                  right: MediaQuery.of(context).size.width*0.12,
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/profile_images/Todo_image.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    padding: EdgeInsets.all(25),
                    margin: EdgeInsets.all(25),
                    width: 250, // Set the width as needed
                    height: 250, // Set the height as needed
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 40), // Adjust top padding
                        child: Text(
                          '130',
                          style: TextStyle(color: Colors.white, fontSize: 70),
                        ),
                      ),
                    ),
                  ),
                ),
                // Second container
                Positioned(
                  top: MediaQuery.of(context).size.height*0.6,
                  right: MediaQuery.of(context).size.width*0.12,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/profile_images/Points_image.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    padding: EdgeInsets.all(25),
                    margin: EdgeInsets.all(25),
                    width: 250, // Set the width as needed
                    height: 250, // Set the height as needed
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 40), // Adjust top padding
                        child: Text(
                          '${points}',
                          style: TextStyle(color: Colors.white, fontSize: 70),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned.fill(
              child: Visibility(
                visible: isOverlayVisible,
                child: InfoOverlay(
                  onClose: hideOverlay,
                  overlayImage: 'assets/overlays/Profile_info_overlay.png',
                ),
              ),
            ),
        ],
      ),
    );
  }
  Future<void> _initializeData() async {
    userId = await DeviceUtils.getDeviceId();
    points = await _fetchInitialPoints();
  }
  Future<int> _fetchInitialPoints() async {
    var pointsgetter;
    if (userId.isNotEmpty) {
      DocumentSnapshot<Map<String, dynamic>> userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userSnapshot.exists) {
        Map<String, dynamic>? userData = userSnapshot.data();

        if (userData != null && userData.containsKey('points')) {
          // Field "points" exists, retrieve its value
          pointsgetter = userData['points'] ?? 0;
        } else {
          // Field "points" doesn't exist, handle accordingly
        }
      }
    }
    return pointsgetter;

  }


}
