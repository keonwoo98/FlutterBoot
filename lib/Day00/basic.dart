import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterBoot Day00',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const HelloFlutter(),
    );
  }
}

class HelloFlutter extends StatefulWidget {
  const HelloFlutter({super.key});

  @override
  State<HelloFlutter> createState() => _HelloFlutterState();
}

class _HelloFlutterState extends State<HelloFlutter> {
  int score = 0;

  void increaseScore() {
    setState(() {
      score++;
    });
  }

  void decreaseScore() {
    setState(() {
      score--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.home),
          title: const Text('Hello Flutter'),
          actions: const [
            SizedBox(width: 56, height: 56, child: Icon(Icons.help))
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Your Score',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 28,
                )),
            Text(
              score.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 32,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FilledButton(
                  onPressed: () {
                    setState(() {
                      score++;
                    });
                  },
                  child: const Text('+'),
                ),
                const SizedBox(width: 10),
                FilledButton(
                  onPressed: () {
                    setState(() {
                      score--;
                    });
                  },
                  child: const Text('-'),
                ),
              ],
            )
          ],
        ));
  }
}
