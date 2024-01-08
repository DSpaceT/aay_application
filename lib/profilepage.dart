import 'package:flutter/material.dart';
import 'widgets/custom_appbar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              showSettings: false,
              showProfile: true,
              showInfo: true,
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
                    decoration: BoxDecoration(
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
                          '20',
                          style: TextStyle(color: Colors.white, fontSize: 70),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
