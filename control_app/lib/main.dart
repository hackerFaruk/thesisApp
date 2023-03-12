import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      backgroundColor: const Color.fromARGB(255, 100, 104, 105),
      appBar: AppBar(
        title: const Text('Motor Kontrol'),
        backgroundColor: const Color.fromARGB(255, 32, 197, 216),
      ),
      body: const Center(
        child: ControlButtons()
      ),
    
    
    ),
  ));
}

class ControlButtons extends StatefulWidget {
  const ControlButtons({super.key});

  @override
  State<ControlButtons> createState() => _ControlButtonsState();
}

class _ControlButtonsState extends State<ControlButtons> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children:  [
           const Text('Control Buttons '),
          Row( children: [
            ElevatedButton(onPressed: () { print('pressed'); },
              child: const Image( image: AssetImage('images/rotate.png'),)), 
          ElevatedButton(onPressed:() {print('pressed reverse');}, 
              child:  const Image( image: AssetImage('images/rotateBack.png')))],
          
          )
          ],
      ),
    );
  }
}
