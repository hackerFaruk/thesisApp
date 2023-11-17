import 'package:flutter/material.dart';
import 'dropdown.dart' as drop;
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'mainPage.dart' as mainpage;

class login extends StatelessWidget {
  const login({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome Back!!',
      home: loginPage(),
    );
  }
}

class loginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text('Provide login data '),
        ),
        body: Center(
            child: Column(
          children: [
            //unfocusbale column

            InkWell(
              onTap: () {
                FocusScope.of(context).previousFocus();
              },
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              child: Column(children: [
                Container(
                  height: screenSize.height * 0.05,
                ),
                const Image(image: AssetImage('images/abyssos.jpg')),
                Container(
                  height: screenSize.height * 0.1,
                ),
                //const emergencyStop.emergencyStop(),
                Text(
                  "LÜTFEN KARTI OKUTUNUZ!",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.blue[800],
                  ),
                ),
                Text(
                  "PLEASE READ KEYCARD!",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.blue[800],
                  ),
                ),
                Container(),
              ]),
            ), // inkwel ended

            TextField(
              autofocus: true,
              onSubmitted: (value) async {
                // login yönlendirici
                if (value != "alp" && value != "1234") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const mainpage.mainPage()),
                  );
                }
              },
            ), // texfield ended
          ],
        ) // column ended
            ) // center ended
        );
  }
}
