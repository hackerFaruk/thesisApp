import 'package:flutter/material.dart';

class mainPage extends StatelessWidget {
  const mainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    return Container(
        child: Column(
      children: [
        SizedBox(
          height: screenWidth * 0.4,
        ),
        ElevatedButton(
          style: style,
          onPressed: () {},
          child: const Text('Guided Exercise Mode'),
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          style: style,
          onPressed: () {},
          child: const Text('Free Movement Mode'),
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          style: style,
          onPressed: () {},
          child: const Text('Exercise Settings'),
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          style: style,
          onPressed: () {},
          child: const Text('System Settings'),
        ),
      ],
    ));
  }
}
