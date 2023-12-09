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
      title: 'FlutterBoot',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const HelloDraggablePage(),
    );
  }
}

abstract class Figure {}

class Rectangle extends Figure {}

class Circle extends Figure {}

class HelloDraggablePage extends StatelessWidget {
  const HelloDraggablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hello Draggable!')),
      body: const HelloDraggable(),
    );
  }
}

class HelloDraggable extends StatefulWidget {
  const HelloDraggable({super.key});

  @override
  State<HelloDraggable> createState() => _HelloDraggableState();
}

class _HelloDraggableState extends State<HelloDraggable> {
  int numberOfRectangles = 0;
  int numberOfCircles = 0;
  late Figure nowFigure = getNextFigure();

  Figure getNextFigure() {
    return Random().nextDouble() < 0.5 ? Rectangle() : Circle();
  }

  void onAccept(Figure figure) {
    if (figure is Rectangle) {
      setState(() {
        numberOfRectangles++;
        nowFigure = getNextFigure();
      });
    } else {
      setState(() {
        numberOfCircles++;
        nowFigure = getNextFigure();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FigureDragTarget(
                  figure: Rectangle(),
                  onAccept: onAccept,
                  child: Text(numberOfRectangles.toString()),
                ),
                FigureDragTarget(
                  figure: Circle(),
                  onAccept: onAccept,
                  child: Text(numberOfCircles.toString()),
                ),
              ],
            ),
          ),
        ),
        Center(child: FigureDraggable(figure: nowFigure)),
        const SizedBox(height: 40),
      ],
    );
  }
}

class FigureWidget extends StatelessWidget {
  final bool isFocused;
  final Figure figure;
  final Size size;
  final Color borderColor;
  final Widget? child;

  const FigureWidget({
    super.key,
    required this.isFocused,
    required this.figure,
    required this.size,
    required this.borderColor,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        border: Border.all(width: isFocused ? 5 : 2, color: borderColor),
        borderRadius: BorderRadius.circular(figure is Rectangle ? 8 : 300),
      ),
      alignment: Alignment.center,
      child: child,
    );
  }
}

class FigureDragTarget extends StatefulWidget {
  final Figure figure;
  final void Function(Figure) onAccept;
  final Widget child;

  const FigureDragTarget({
    super.key,
    required this.figure,
    required this.onAccept,
    required this.child,
  });

  @override
  State<FigureDragTarget> createState() => _FigureDragTargetState();
}

class _FigureDragTargetState extends State<FigureDragTarget> {
  bool isMoving = false;

  void setIsMoving(bool newValue) => setState(() => isMoving = newValue);

  void setIsMovingFromData(Figure? data, bool isMoving) {
    if (data == null) return;
    if (data.runtimeType == widget.figure.runtimeType) {
      setIsMoving(isMoving);
    }
  }

  bool onWillAccept(Figure? data) {
    return data.runtimeType == widget.figure.runtimeType;
  }

  void onAceept(Figure data) {
    setIsMoving(false);
    widget.onAccept(data);
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget<Figure>(
      onMove: (details) => setIsMovingFromData(details.data, true),
      onLeave: (data) => setIsMovingFromData(data, false),
      onWillAccept: onWillAccept,
      onAccept: onAceept,
      builder: (_, __, ___) {
        return FigureWidget(
          isFocused: isMoving,
          figure: widget.figure,
          size: const Size(100, 100),
          borderColor: Colors.black,
          child: widget.child,
        );
      },
    );
  }
}

class FigureDraggable extends StatelessWidget {
  final Figure figure;

  const FigureDraggable({super.key, required this.figure});

  Widget _buildFigureWidget() {
    return FigureWidget(
      isFocused: false,
      figure: figure,
      size: const Size(80, 80),
      borderColor: Colors.black,
      child: const DefaultTextStyle(
        style: TextStyle(),
        child: Text('Drag Me!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Draggable<Figure>(
      data: figure,
      feedback: _buildFigureWidget(),
      childWhenDragging: const SizedBox(width: 80, height: 80),
      child: _buildFigureWidget(),
    );
  }
}
