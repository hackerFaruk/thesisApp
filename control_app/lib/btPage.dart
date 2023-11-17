import 'package:flutter/material.dart';
import 'dropdown.dart' as drop;
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

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
