import 'package:flutter/material.dart';
import 'overlay_function.dart';
import 'minutes_selector.dart';

class ScheduleAdder extends StatefulWidget {
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final VoidCallback onClose;
  final ValueChanged<int> onMinutesSelected;

  ScheduleAdder({
    Key? key,
    required this.onSave,
    required this.onCancel,
    required this.onClose,
    required this.onMinutesSelected,
  }) : super(key: key);

  @override
  _ScheduleAdderState createState() => _ScheduleAdderState();
}

class _ScheduleAdderState extends State<ScheduleAdder> {
  int selectedMinutes = 0;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.fromARGB(255, 237, 70, 196),
      content: Container(
        height: 350,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            ScrollableMinutesSelector(
              onMinutesSelected: (minutes) {
                setState(() {
                  selectedMinutes = minutes;
                  widget.onMinutesSelected(selectedMinutes);
                });
            },
            ),


            // buttons -> save + cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // save button
                MyButton(
                  text: "Set",
                  onPressed:()=>{
                    widget.onSave(),
                    // widget.onMinutesSelected(selectedMinutes),
                  }),

                const SizedBox(width: 8),

                // cancel button
                MyButton(
                  text: "Cancel",
                   onPressed: ()=>{
                    widget.onCancel(),
                  },
                ),

              ],
            ),

          ],
        ),
      ),
    );
  }
}

