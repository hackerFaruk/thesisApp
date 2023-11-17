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
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32.0,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32.0,
                ),
              ),
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                // Handle login action
                String username = _usernameController.text;
                String password = _passwordController.text;

                // Implement your login logic here
                if (username == 'alp' && password == '1234') {
                  // Navigate to the next screen or perform desired action
                  print('Login successful!');
                } else {
                  // Display an error message or handle authentication failure
                  print('Login failed. Check your credentials.');
                }
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}









/*
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
*/