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
        child: Image(
          image: NetworkImage(
              'https://www.tutorialkart.com/wp-content/uploads/2021/11/flutter-scaffold-iphone-1.png'),
        ),
      ),
    
    
    ),
  ));
}
