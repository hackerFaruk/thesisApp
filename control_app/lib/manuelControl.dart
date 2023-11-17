import 'package:flutter/material.dart';

import 'dropdown.dart' as drop;

class manuelControl extends StatelessWidget {
  const manuelControl({super.key});

  @override
  Widget build(BuildContext context) {
    return ControlButtons();
  }
}

class ControlButtons extends StatefulWidget {
  final String img; // initlize parameter

  const ControlButtons({
    Key? key,
    this.img = "", // non-nullable but optional with a default value
  }) : super(key: key);

  @override
  State<ControlButtons> createState() => _ControlButtonsState();
}

class _ControlButtonsState extends State<ControlButtons> {
  String toolTip = "Press Buttons To Rotate";
  String baseIcon = 'images/rotateBack.png';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              ' $toolTip',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Colors.blue,
                letterSpacing: 1.5,
                decoration: TextDecoration.underline,
                decorationColor: Color.fromARGB(255, 123, 80, 77),
                decorationStyle: TextDecorationStyle.double,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            // gesturedetector has a weird use you need behaviour

            Row(
              //buttonsRow
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  //responsive size with constrains
                  constraints: const BoxConstraints(
                      minHeight: 100,
                      minWidth: 100,
                      maxHeight: 600,
                      maxWidth: 600),
                  width: screenWidth / 4,

                  height: screenWidth / 4,
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          toolTip = "Extending Arm";
                        });
                      },
                      child: const Image(
                        image: AssetImage('images/rotate.png'),
                      )),
                ),
                Container(
                  constraints: const BoxConstraints(
                      minHeight: 100,
                      minWidth: 100,
                      maxHeight: 600,
                      maxWidth: 600),
                  width: screenWidth / 4,
                  height: screenWidth / 4,
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          toolTip = "Flexing Arm";
                        });
                      },
                      child: const Image(
                          image: AssetImage('images/rotateBack.png'))),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const drop.DropdownButtonExample(),
          ],
        ),
      ),
    );
  }
}

class CoolButton extends StatefulWidget {
  final String icon;

  const CoolButton({this.icon = "", super.key});

  @override
  State<CoolButton> createState() => _CoolButtonState();
}

class _CoolButtonState extends State<CoolButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      height: 200.0,
      decoration:
          const BoxDecoration(shape: BoxShape.circle, color: Colors.cyan),
      child: ElevatedButton(
          onPressed: () {
            print('Button Pressed');
          },
          child: const Image(
            image: AssetImage('images/rotate.png'),
          )),
    );
  }
}

class GestureControls extends StatefulWidget {
  const GestureControls({super.key});

  @override
  State<GestureControls> createState() => _GestureControlsState();
}

class _GestureControlsState extends State<GestureControls> {
  var currentGesture = " try me ";

  @override
  Widget build(BuildContext context) {
    // responsive için ekran boyu alma
    final currentWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      child: Container(
        width: 100.0,
        height: 100.0,
        color: currentWidth > 600 ? Colors.orange : Colors.teal,
        child: Text(currentGesture),
      ),
      onTap: () => setState(() {
        currentGesture = "You tapped me";
      }),
    );
  }
}
