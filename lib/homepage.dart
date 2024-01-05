import 'package:flutter/material.dart';



class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double imagePercentage = 0.2;

    return GestureDetector(
      onHorizontalDragUpdate: (DragUpdateDetails details) {
        double screenWidth = MediaQuery.of(context).size.width;

        if (details.primaryDelta! < 0 && details.globalPosition.dx > screenWidth / 2) {
          _navigateToCoffeePage(context);
        }else if(details.primaryDelta! >0 && details.globalPosition.dx < screenWidth / 2){
          _navigateToStudyPage(context);
        }
        
      },
      onVerticalDragUpdate: (DragUpdateDetails details){
        double screenHeight = MediaQuery.of(context).size.height;

        if(details.primaryDelta! < 0 && details.globalPosition.dy > screenHeight * 3/4){
          _navigateToTasksPage(context);
        }
      },
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/HomePage_img.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 345 / 800,
            left: (MediaQuery.of(context).size.width) * 4 / 5 - (MediaQuery.of(context).size.width * imagePercentage) / 2,
            child: _buildImage(context, 'assets/Book_image.png', imagePercentage),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 345 / 800,
            left: (MediaQuery.of(context).size.width) * 1 / 5 - (MediaQuery.of(context).size.width * imagePercentage) / 2,
            child: _buildImage(context, 'assets/Coffee_image.png', imagePercentage),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 7 / 8,
            left: (MediaQuery.of(context).size.width) * 1/2 - (MediaQuery.of(context).size.width * imagePercentage) / 2,
            child: _buildImage(context, 'assets/Tasks_icon.png', imagePercentage),
          ),
        ],
      ),
    );
  }
  void _navigateToStudyPage(BuildContext context) {
    Navigator.pushNamed(context, '/studypage');
  }
  void _navigateToCoffeePage(BuildContext context){
    Navigator.pushNamed(context,'/coffeeplaces');
  }
  void _navigateToTasksPage(BuildContext context){
    Navigator.pushNamed(context, '/taskspage');
  }
  Widget _buildImage(BuildContext context, String imagePath, double percentage) {
    double imageSize = MediaQuery.of(context).size.width * percentage;
    return Image.asset(
      imagePath,
      width: imageSize,
      height: imageSize,
      fit: BoxFit.cover,
    );
  }
}

