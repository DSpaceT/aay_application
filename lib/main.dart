import 'package:flutter/material.dart';
import 'next.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Define the routes
      routes: {
        '/': (context) => const MyHomePage(),
        '/next': (context) => const NextPage(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double imagePercentage = 0.2;

    return GestureDetector(
      onHorizontalDragUpdate: (DragUpdateDetails details) {
        double screenWidth = MediaQuery.of(context).size.width;

        if (details.primaryDelta! < 0 && details.globalPosition.dx > screenWidth / 2) {
          _navigateToNextPage(context);
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
        ],
      ),
    );
  }
  void _navigateToNextPage(BuildContext context) {
    Navigator.pushNamed(context, '/next');
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

