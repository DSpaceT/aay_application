import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'widgets/custom_appbar.dart';
import 'utils/device_id.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'widgets/overlay_function.dart';
import 'widgets/rewards_list.dart';
import 'widgets/rewards_list.dart';

bool globalrewards = false;
int lengthrewards = 0;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String userId;
  late int points = 0; // Initialize with a default value
  late int taskscompleted = 0;
  bool isOverlayVisible = false;
  bool rewards = globalrewards;
  bool isOverlayVisiblecoupon = false;
  String overlaycoupon = "false";

  List<Reward> rewardsList = [];


  @override
  void initState() {
    super.initState();
    _initializeData();
  }


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
    lengthrewards = rewardsList.length;
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
          // Your ProfilePage content goes here
          // For example, you can add two containers with images and text in the center:
          Center(
            child: rewards
            ? Stack(
              children: [
                Positioned(
                  top: MediaQuery.of(context).size.height*0.23,
                  right: MediaQuery.of(context).size.width*0.38,
                  child:ElevatedButton(
                    child: Text("rewards"),
                    onPressed: () {
                      setState(() {
                        rewards = !rewards;
                        globalrewards = !globalrewards;
                      });

                    },
                    )
                ),
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
                          '${taskscompleted}',
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
            )
            :Stack(
              children:[
                ListView.builder(
                  itemCount: 1 + rewardsList.length,
                  padding: EdgeInsets.only(top: 150.0,left:10),
                  itemExtent: 125.0,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return SizedBox.shrink();
                    }
                    return rewardsList[index - 1];
                  },
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height*0.23,
                  right: MediaQuery.of(context).size.width*0.38,
                  child:ElevatedButton(
                    child: Text("stats"),
                    onPressed: () {
                      print("hello world");
                      setState(() {
                        rewards = !rewards;
                        globalrewards = !globalrewards;
                      });

                    },
                ),
                ),
              ]
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
              infoCallback: showOverlay,
              // You can add other properties/callbacks as needed
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
          Positioned.fill(
              child: Visibility(
                visible: isOverlayVisiblecoupon,
                child: InfoOverlay(
                  onClose:(){
                    setState(() {
                      isOverlayVisiblecoupon = false;
                    });
                  },
                  overlayImage: overlaycoupon,//'assets/overlays/Profile_info_overlay.png',
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
    taskscompleted = await _fetchInitialTasksCompleted();
    rewardsList = [
      Reward(
        name: 'Mickel coupon',
        imageAsset: 'assets/coupons/Coupon_mickel.png',
        onButtonPressed: toggleCouponOverlayVisibility,
        index:1,
      ),
      Reward(
        name: 'Mickel coupon 2',
        imageAsset: 'assets/coupons/Coupon_mickel_2.png',
        onButtonPressed: toggleCouponOverlayVisibility,
        index:2,
      ),
      Reward(
        name: 'Starbucks coupon',
        imageAsset: 'assets/coupons/Coupon_starbucks.png',
        onButtonPressed: toggleCouponOverlayVisibility,
        index :3,
      ),
      // Add more Reward instances as needed
    ];
  }
  void toggleCouponOverlayVisibility(int index) {
    if(index == 1 || index == 2){
      overlaycoupon = "assets/coupon_codes/Coupon_code_1.png";
    }else{
      overlaycoupon = "assets/coupon_codes/Coupon_code_2.png";
    }
    print("i am here");
    setState(() {
      print("state changed");
      isOverlayVisiblecoupon = !isOverlayVisiblecoupon;//!isOverlayVisiblecoupon;
    });
  }
  Future<int> _fetchInitialPoints() async {
    var pointsgetter = 0;
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
    Future<int> _fetchInitialTasksCompleted() async {
    var tasksgetter = 0;
    if (userId.isNotEmpty) {
      DocumentSnapshot<Map<String, dynamic>> userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userSnapshot.exists) {
        Map<String, dynamic>? userData = userSnapshot.data();

        if (userData != null && userData.containsKey('taskscompleted')) {
          // Field "points" exists, retrieve its value
          tasksgetter = userData['taskscompleted'] ?? 0;
        } else {
          // Field "points" doesn't exist, handle accordingly
        }
      }
    }
    return tasksgetter;

  }


}
