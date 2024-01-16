import 'package:flutter/material.dart';
import 'widgets/overlay_function.dart';
import 'widgets/custom_appbar.dart';
import 'utils/device_id.dart';
import 'widgets/places_list.dart';
import 'package:tuple/tuple.dart';

class PlacesPage extends StatefulWidget {
  const PlacesPage({Key? key}) : super(key: key);

  @override
  _PlacesPageState createState() => _PlacesPageState();
}

class _PlacesPageState extends State<PlacesPage> {
  bool isOverlayVisible = false;

  late String userId; // User ID

  List<Place> placesList = [
    Place(
      name: 'starbucks',
      imageAsset: 'assets/places/Starbucks_place.png',
      isCompleted: false,
      location: Tuple2(37.97575, 23.75225),//Tuple2(37, -122),
    ),
    Place(
      name: 'coffee island',
      imageAsset: 'assets/places/Coffee_island_place.png',
      isCompleted: false,
      location: Tuple2(37.978030, 23.769156),
    ),
    Place(
      name: 'Mickel',
      imageAsset: 'assets/places/Mickel_place.png',
      isCompleted: false,
      location: Tuple2(37.978421, 23.768129),
    ),
    Place(
      name: 'BooksBeans',
      imageAsset: 'assets/places/BooksBeans_place.png',
      isCompleted: false,
      location: Tuple2(37.97167, 23.75047),
    ),
    // Add more Place instances as needed
  ];

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
                showSettings: false,
                showProfile: true,
                showInfo: true,
                infoCallback: showOverlay,
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.25,
              left: 0,
              child: PlacesList(
                places: placesList,
                userId: userId,
              ),
            ),
            Visibility(
              visible: isOverlayVisible,
              child: InfoOverlay(
                onClose: hideOverlay,
                overlayImage: 'assets/overlays/Places_info_overlay.png',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _initializeData() async {
    userId = await DeviceUtils.getDeviceId();
  }
}
