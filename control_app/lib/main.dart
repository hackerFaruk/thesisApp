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
  String toolTip = "Press Buttons To Rotate";
  String baseIcon = 'images/rotateBack.png';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () => print('i am a gesture detector'),
              behavior: HitTestBehavior.translucent,
              child: Text(' $toolTip'),
            ), // gesturedetector has a weird use you need behaviour

            Row(
              children: [
                Container(
                  //responsive size with constrains
                  constraints: const BoxConstraints(
                      minHeight: 100,
                      minWidth: 100,
                      maxHeight: 300,
                      maxWidth: 300),
                  width: screenWidth / 10,
                  padding: const EdgeInsets.all(10),
                  height: screenWidth / 10,
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
                      maxHeight: 300,
                      maxWidth: 300),
                  width: screenWidth / 10,
                  height: screenWidth / 10,
                  padding: const EdgeInsets.all(10),
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
            const GestureControls(),
            const CoolButton(icon: 'images/bt.png'),
            ElevatedButton(
                onPressed: () {
                  // change to page bluetoothPage
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BluetoothPage()));

                  print('er');
                },
                child: Text('PAge')),
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

class BluetoothPage extends StatefulWidget {
  const BluetoothPage({super.key});

  @override
  State<BluetoothPage> createState() => _BluetoothPageState();
}

class _BluetoothPageState extends State<BluetoothPage> {
  @override
  Widget build(BuildContext context) {
    final pageSize = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Bluetooth Page'),
            backgroundColor: Colors.blueGrey,
          ),
          body: Center(
            child: SizedBox(
                width: pageSize.width / 3,
                height: pageSize.height / 5,
                child: ElevatedButton(
                  onPressed: () {
                    // Go back to main

                    Navigator.pop(context);

                    print('change page');
                  },
                  style:
                      ElevatedButton.styleFrom(fixedSize: const Size(150, 50)),
                  child: const Text('Change Pages now'),
                )),
          )),
    );
  }
}
