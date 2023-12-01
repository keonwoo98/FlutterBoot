import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterBoot Day02',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHighScore(),
    );
  }
}

class MyHighScore extends StatefulWidget {
  const MyHighScore({super.key});

  @override
  State<MyHighScore> createState() => _MyHighScoreState();
}

class _MyHighScoreState extends State<MyHighScore>
    with SingleTickerProviderStateMixin {
  int score = 0;
  late AnimationController _animationController;
  late Animation<double> _animation;
  ValueNotifier<double> gaugeValue = ValueNotifier(0.0);
  Timer? timer;

  @override
  void initState() {
    super.initState();
    gaugeValue.addListener(() {
      if (gaugeValue.value <= 0) {
        resetScore();
      }
    });
    timer = Timer.periodic(const Duration(milliseconds: 500), (_) {
      if (gaugeValue.value > 0) {
        setState(() {
          _animationController.reverse();
          gaugeValue.value = _animation.value;
        });
      }
    });
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    _animationController.addListener(() {
      setState(() {
        gaugeValue.value = _animation.value;
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    timer?.cancel();
    gaugeValue.dispose();
    super.dispose();
  }

  void startAnimation() {
    gaugeValue.value += 0.2;
    _animationController.animateTo(gaugeValue.value);
  }

  void onButtonPressed() {
    if (gaugeValue.value < 1) {
      startAnimation();
    }
    if (gaugeValue.value >= 1) {
      incrementScore();
    }
  }

  void resetScore() {
    setState(() {
      score = 0;
    });
  }

  void incrementScore() {
    setState(() {
      score++;
    });
  }

  Widget _gaugeBar() {
    double barHeight = MediaQuery.of(context).size.height * 0.4;
    double gaugeHeight = barHeight * gaugeValue.value;
    const borderRadius = BorderRadius.only(
        topLeft: Radius.circular(16), topRight: Radius.circular(16));
    return Container(
      width: 40,
      height: barHeight,
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: borderRadius,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 40,
            height: gaugeHeight * gaugeValue.value,
            decoration: const BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: borderRadius,
            ),
          ),
        ],
      ),
    );
  }

  Widget _plusButton() {
    return FloatingActionButton(
      onPressed: onButtonPressed,
      child: const Text(
        '+',
        style: TextStyle(fontSize: 30),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              children: [
                const SizedBox(height: 32),
                const Text(
                  'Your Score',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.normal),
                ),
                const SizedBox(height: 16),
                Text(
                  score.toString(),
                  style: const TextStyle(
                      fontSize: 46, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Positioned(
              right: 24,
              bottom: 24,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _gaugeBar(),
                  const SizedBox(height: 8),
                  _plusButton(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
