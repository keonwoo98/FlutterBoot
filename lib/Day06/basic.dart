import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterBoot Day06',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const HelloDialog(),
    );
  }
}

class HelloDialog extends StatefulWidget {
  const HelloDialog({super.key});

  @override
  State<HelloDialog> createState() => _HelloDialogState();
}

class _HelloDialogState extends State<HelloDialog> {
  int point = 0;

  List<int> generateRandomNumber(int count) {
    List<int> numbers = [];
    while (numbers.length < count) {
      int randomNum = Random().nextInt(100);
      if (!numbers.contains(randomNum)) {
        numbers.add(randomNum);
      }
    }
    return numbers;
  }

  Future<void> _showNumberPickerDialog() async {
    List<int> randomNumbers = generateRandomNumber(3);

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return _buildNumberPickerDialog(randomNumbers);
      },
    );
  }

  Widget _buildNumberButton(int number) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextButton(
        onPressed: () {
          Navigator.of(context).pop();
          setState(() {
            point = number;
          });
        },
        child: Text(
          '$number',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildNumberPickerDialog(List<int> randomNumbers) {
    return AlertDialog(
      title: const Text(
        'Choose your next point!',
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Choose one of the points below!'),
          const Text(
              'If you don\'t make a selection, your current score will be retained.'),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: List.generate(
              3,
              (index) => _buildNumberButton(randomNumbers[index]),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Your point : $point',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                _showNumberPickerDialog();
              },
              child: const Text(
                'I want more points!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 56),
          ],
        ),
      ),
    );
  }
}
