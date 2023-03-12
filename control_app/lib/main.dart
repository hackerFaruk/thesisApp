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
  const ControlButtons({super.key});

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
           Text(' $toolTip'),
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
                      const Image(image: AssetImage('images/rotateBack.png')))
            ],
          )
        ],
      ),
    );
  }
}
