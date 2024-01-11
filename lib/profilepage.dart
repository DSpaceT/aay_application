import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'widgets/custom_appbar.dart';
import 'utils/device_id.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'widgets/overlay_function.dart';
import 'widgets/rewards_list.dart';
import 'widgets/coupon.dart';


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

  late List<Coupon> rewarddescriptions = [];
  late int taskscompleted = 0;
  bool isOverlayVisible = false;
  bool rewards = globalrewards;
  bool isOverlayVisiblecoupon = false;
  String overlaycoupon = "false";
  String page = "stats";

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
            child: (page =="stats")
            ? Stack(
              children: [
                Positioned(
                  top: MediaQuery.of(context).size.height*0.23,
                  left: MediaQuery.of(context).size.width*0.2,
                  child:ElevatedButton(
                    child: Text("coupons"),
                    onPressed: () {
                      setState(() {
                        page = "coupons";
                      });

                    },
                    )
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height*0.23,
                  right: MediaQuery.of(context).size.width*0.2,
                  child:ElevatedButton(
                    child: Text("rewards"),
                    onPressed: () {
                      setState(() {
                        page = "rewards";
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
            : (page == "coupons")
            ?  Stack(
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
                  left: MediaQuery.of(context).size.width*0.2,
                  child:ElevatedButton(
                    child: Text("stats"),
                    onPressed: () {
                      print("hello world");
                      setState(() {
                        page = "stats";
                      });

                    },
                ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height*0.23,
                  right: MediaQuery.of(context).size.width*0.2,
                  child:ElevatedButton(
                    child: Text("rewards"),
                    onPressed: () {
                      print("hello world");
                      setState(() {
                        page = "rewards";
                      });

                    },
                ),
                ),
              ]
            )
            :
              Stack(
                children: [
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.3,
                    left: MediaQuery.of(context).size.width * 0.05,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                        rewarddescriptions.length,
                        (index) {
                          // You can customize the text and style based on index or other conditions
                          Color backgroundColor = index % 2 == 0 ? Colors.blue : Colors.red;
                          Color textColor = Colors.white; // Change text color based on your requirements

                          return Row(
                            children: [
                              Container(
                                width: 300,
                                height: 70,
                                padding: EdgeInsets.all(8.0),
                                margin: EdgeInsets.symmetric(vertical: 20.0),
                                decoration: BoxDecoration(
                                  color: backgroundColor,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Text(
                                  '${rewarddescriptions[index].description}\ncode :\t${rewarddescriptions[index].id}',
                                  style: TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10), // Adjust the spacing between the container and the icon button
                              IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: () {
                                  // Handle minus button tap
                                  _removeRewardFromFirestore(rewarddescriptions[index].id);
                                  setState(() {
                                    
                                  });
                                },
                                color: Colors.white, // Change the icon color based on your requirements
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),


                Positioned(
                  top: MediaQuery.of(context).size.height*0.23,
                  left: MediaQuery.of(context).size.width*0.2,
                  child:ElevatedButton(
                    child: Text("stats"),
                    onPressed: () {
                      print("hello world");
                      setState(() {
                        page = "stats";
                      });

                    },
                ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height*0.23,
                  right: MediaQuery.of(context).size.width*0.2,
                  child:ElevatedButton(
                    child: Text("coupons"),
                    onPressed: () {
                      print("hello world");
                      setState(() {
                        page = "coupons";
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
    rewarddescriptions = await _getAllRewardsFromFirestore();
    rewardsList = [
      Reward(
        name: 'Mickel coupon',
        imageAsset: 'assets/coupons/Coupon_mickel.png',
        onButtonPressed: toggleCouponOverlayVisibility,
        index:1,
        text: "5% off-50p",
        code: "1241332",
        cost: 50,
      ),
      Reward(
        name: 'Mickel coupon 2',
        imageAsset: 'assets/coupons/Coupon_mickel_2.png',
        onButtonPressed: toggleCouponOverlayVisibility,
        index:2,
        text: "5% off-200p",
        code: "1241333",
        cost :200,
      ),
      Reward(
        name: 'Starbucks coupon',
        imageAsset: 'assets/coupons/Coupon_starbucks.png',
        onButtonPressed: toggleCouponOverlayVisibility,
        index :3,
        text: "1+1 coffee-400p",
        code: "1331123",
        cost :400,
      ),
      // Add more Reward instances as needed
    ];
  }
  void toggleCouponOverlayVisibility(Reward reward) {
    if((reward.index == 1 || reward.index == 2) && points >= reward.cost){
      _addRewardToFirestore(reward);
      _updatePointsToFirestore(points - reward.cost);
      //points = points -reward.cost;
      overlaycoupon = "assets/coupon_codes/Coupon_code_1.png";
    }else if (reward.index == 3 && points>= reward.cost){
      _addRewardToFirestore(reward);
      _updatePointsToFirestore(points - reward.cost);
      //points = points- reward.cost;
      overlaycoupon = "assets/coupon_codes/Coupon_code_2.png";
    }else{
      overlaycoupon = "assets/coupon_codes/Notenoughpoints.png";
    }
    setState(() {
      isOverlayVisiblecoupon = !isOverlayVisiblecoupon;//!isOverlayVisiblecoupon;
    });
  }
  Future<void> _updatePointsToFirestore(int pointsnow) async {
    if (userId.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({
            'points':pointsnow,
          })
          .catchError((error) {
            // Handle any errors here
            print('Error adding task to Firestore: $error');
          });
    }
  }
Future<void> _addRewardToFirestore(Reward reward) async {
  if (userId.isNotEmpty) {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('rewards')
        .add({
          'description': reward.text,
          'id': reward.code,
        })
        .then((documentReference) {
          // Successfully added to Firestore, update the local list
          setState(() {}); // Trigger a rebuild to update the UI
        })
        .catchError((error) {
          // Handle any errors here
          print('Error adding task to Firestore: $error');
        });
  }

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
    Future<List<Coupon>> _getAllRewardsFromFirestore() async {
    print("getting data");
    List<Coupon> fetchedCoupons = [];

    if (userId.isNotEmpty) {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('rewards')
          .get();

      fetchedCoupons = querySnapshot.docs.map((doc) => _rewardFromSnapshot(doc)).toList();
    }

    return fetchedCoupons;
  }

  Coupon _rewardFromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    Map<String, dynamic> data = snapshot.data();
    return Coupon(
      id: data['id'],
      description: data['description'] ?? '',
    );
  }
  Future<void> _removeRewardFromFirestore(String rewardCode) async {
  if (userId.isNotEmpty) {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('rewards')
        .where('id', isEqualTo: rewardCode)
        .get();

    // Check if there is any matching document
    if (querySnapshot.size > 0) {
      // Delete the document(s)
      for (QueryDocumentSnapshot<Map<String, dynamic>> document in querySnapshot.docs) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('rewards')
            .doc(document.id)
            .delete()
            .then((_) {
              // Successfully removed from Firestore, update the local list or UI if needed
            })
            .catchError((error) {
              // Handle any errors here
              print('Error removing reward from Firestore: $error');
            });
      }
    } else {
      // Handle the case when no matching document is found
      print('Reward with code $rewardCode not found.');
    }
  }
}



}
