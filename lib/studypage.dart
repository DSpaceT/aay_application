import 'package:flutter/material.dart';
import 'widgets/custom_appbar.dart';

class StudyPage extends StatelessWidget {
  const StudyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (DragUpdateDetails details) {
        if (details.primaryDelta! > 0) {
          _navigateToTasksPage(context);
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/StudyPage.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: CustomAppBar(
                title: 'Another Page',
                showSettings: true,
                showProfile: false, // Hide the profile button
                showInfo: false, // Hide the info button

              ),

            ),
            
            // Add other widgets on top of the background image as needed
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: MediaQuery.of(context).size.height / 6,
              child: GestureDetector(
                onTap: () {
                  // Add your invisible button's onPressed functionality here
                  _navigateToMusicPage(context);
                },
                child: Container(
                  color: Colors.transparent,
                  // You can customize the height, color, and other properties as needed
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToTasksPage(BuildContext context) {
    Navigator.pushNamed(context, '/taskspage');
  }
  void _navigateToMusicPage(BuildContext context){
    Navigator.pushNamed(context, '/musicpage');
  }
}
