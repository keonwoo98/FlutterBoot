import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
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
    timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (gaugeValue.value > 0) {
        setState(() {
          _animationController.reverse();
          gaugeValue.value = _animation.value;
        });
      }
    });
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    _animationController.addListener(() {
      setState(() {
        gaugeValue.value = _animation.value;
      });
    });
  }

  void _startAnimation() {
    gaugeValue.value += 0.2;
    _animationController.animateTo(gaugeValue.value);
  }

  void onButtonPressed() {
    if (gaugeValue.value < 1) {
      _startAnimation();
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
    return SizedBox(
        child: Container(
      width: 50,
      height: barHeight,
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 50,
            height: gaugeHeight * gaugeValue.value,
            decoration: const BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  Widget _plusButton() {
    return SafeArea(
      child: ElevatedButton(
        onPressed: () {
          onButtonPressed();
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(16.0),
          minimumSize: const Size.square(60),
          backgroundColor: Colors.purple.shade50,
        ),
        child: const Text(
          '+',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Your Score',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.normal),
              ),
              Text(
                '$score',
                style:
                    const TextStyle(fontSize: 46, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      _gaugeBar(),
                      const SizedBox(height: 16),
                      _plusButton(),
                      const SizedBox(height: 16),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    timer?.cancel();
    gaugeValue.dispose();
    super.dispose();
  }
}
