import 'package:flutter/material.dart';

void showOverlay(BuildContext context, String overlayImage) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return InfoOverlay(
        onClose: () {
          Navigator.pop(context); // Close the overlay
        },
        overlayImage: overlayImage,
      );
    },
  );
}

class InfoOverlay extends StatelessWidget {
  final Function() onClose;
  final String overlayImage;

  InfoOverlay({
    required this.onClose,
    required this.overlayImage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClose,
      child: Container(
        color: Colors.black.withOpacity(0.5),
        child: Center(
          child: Image.asset(
            overlayImage,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

class MyButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  MyButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: widget.onPressed,
      color: Color.fromARGB(255, 22, 142, 223),
      textColor: Color.fromARGB(255, 255, 222, 124),
      child: Text(widget.text),
    );
  }
}

class DialogBox extends StatefulWidget {
  final TextEditingController controller;
  final TextEditingController controller2;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final VoidCallback onClose;

  DialogBox({
    Key? key,
    required this.controller,
    required this.controller2,
    required this.onSave,
    required this.onCancel,
    required this.onClose,
  }) : super(key: key);

  @override
  _DialogBoxState createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  final _textKey = GlobalKey<FormState>();
  final _textKey2 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.fromARGB(255, 160, 13, 62),
      content: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // get user input
            Form(
              key: _textKey,
              child: TextField(
                controller: widget.controller,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(255, 224, 170, 8),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  hintText: "Task Title",
                ),
              ),
            ),

            Form(
              key: _textKey2,
              child: TextField(
                controller: widget.controller2,
                maxLines: 10, // Allow unlimited lines
                keyboardType: TextInputType.multiline, // Enable multiline input
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(255, 224, 170, 8),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  hintText: "Add new task",
                ),
              ),
            ),

            // buttons -> save + cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // save button
                MyButton(
                    text: "Save",
                    onPressed: () => {
                          widget.onSave(),
                        }),

                const SizedBox(width: 8),

                // cancel button
                MyButton(
                  text: "Cancel",
                  onPressed: () => {
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
