
import 'package:flutter/material.dart';

class PlacesPage extends StatelessWidget {
  const PlacesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onHorizontalDragUpdate: (DragUpdateDetails details) {
        
      },
      child :Scaffold(
        appBar: AppBar(
          title: const Text('PlacesPage'),
          ),
      
        body : Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/PlacesPage.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          //add other things here......
          ],
        ),
      ),
    );
  }

  
}
