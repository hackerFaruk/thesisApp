import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      backgroundColor: const Color.fromARGB(255, 100, 104, 105),
      appBar: AppBar(
        title: const Text('Motor Kontrol'),
        backgroundColor: const Color.fromARGB(255, 32, 197, 216),
      ),
      body: const Center(child: ControlButtons()),
    ),
  ));
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
  var toolTip = "Press Buttons To Rotate";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          GestureDetector(
            child:  Text(' $toolTip'),
            onTap: () => print('i am a gesture detector'),
            behavior: HitTestBehavior.translucent,
          ), // gesturedetector has a weird use you need behaviour

          Row(
            children: [
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      toolTip = "Extending Arm";
                    });
                  },
                  child: const Image(
                    image: AssetImage('images/rotate.png'),
                  )),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      toolTip = "Flexing Arm";
                    });
                  },
                  child:
                      const Image(image: AssetImage('images/rotateBack.png'))),
              const CoolButton(icon: 'images/rotate.png'),
              
            ],
          ),
           const GestureControls(),
        ],
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
    return GestureDetector(
      child: Container(
        width: 100.0,
        height: 100.0,
        color: Colors.orange,
        child: Text('$currentGesture'),
      ), onTap: () => setState(() {
        currentGesture = "You tapped me";
      }),
    );
  }
}
