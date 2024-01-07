import 'package:flutter/material.dart';

class ScrollableMinutesSelector extends StatefulWidget {
  final ValueChanged<int> onMinutesSelected;
  ScrollableMinutesSelector({required this.onMinutesSelected});
  @override
  _ScrollableMinutesSelectorState createState() => _ScrollableMinutesSelectorState();
}

class _ScrollableMinutesSelectorState extends State<ScrollableMinutesSelector> {
  int selectedMinutes = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width : 200,
      height: 200, // Set the height of the widget
      child: GestureDetector(
        onVerticalDragUpdate: (details) {
          setState(() {
            // Adjust the sensitivity based on your preference
            selectedMinutes += (details.primaryDelta!*0.5).toInt() ; // Increase sensitivity

            // Ensure the selected minutes stay within the valid range (0 to 59)
            selectedMinutes = selectedMinutes.clamp(0, 59);
            widget.onMinutesSelected(selectedMinutes);
          });
        },
        child: Container(
          alignment: Alignment.center,
          color: Colors.blue,
          child: Text(
            '$selectedMinutes minutes',
            style: TextStyle(fontSize: 30, color: Colors.white), // Increase font size
          ),
        ),
      ),
    );
  }
}