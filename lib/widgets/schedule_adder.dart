import 'package:flutter/material.dart';
import 'overlay_function.dart';
import 'minutes_selector.dart';

class ScheduleAdder extends StatefulWidget {
  final TextEditingController controller;
  final TextEditingController controller2;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final VoidCallback onClose;

  ScheduleAdder({
    Key? key,
    required this.controller,
    required this.controller2,
    required this.onSave,
    required this.onCancel,
    required this.onClose,
  }) : super(key: key);

  @override
  _ScheduleAdderState createState() => _ScheduleAdderState();
}

class _ScheduleAdderState extends State<ScheduleAdder> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.fromARGB(255, 237, 70, 196),
      content: Container(
        height: 350,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            ScrollableMinutesSelector(),


            // buttons -> save + cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // save button
                MyButton(
                  text: "Save",
                  onPressed:()=>{
                    widget.onSave(),
                  }),

                const SizedBox(width: 8),

                // cancel button
                MyButton(
                  text: "Cancel",
                   onPressed: ()=>{
                    widget.onCancel(),
                    widget.controller.clear(),
                    widget.controller2.clear(),
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

