import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterBoot Day04',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyTextField(),
    );
  }
}

class MyTextField extends StatefulWidget {
  const MyTextField({super.key});

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  TextEditingController leftInputController =
      TextEditingController(text: 'Hello');
  TextEditingController rightInputController =
      TextEditingController(text: 'FlutterBoot!');
  FocusNode leftInputFocusNode = FocusNode();
  FocusNode rightInputFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    leftInputFocusNode.onKey = (FocusNode node, RawKeyEvent event) {
      if (event is RawKeyDownEvent &&
          event.logicalKey == LogicalKeyboardKey.backspace &&
          leftInputController.text.isEmpty) {
        rightInputFocusNode.requestFocus();
        return KeyEventResult.handled;
      }
      return KeyEventResult.ignored;
    };
    rightInputFocusNode.onKey = (FocusNode node, RawKeyEvent event) {
      if (event is RawKeyDownEvent &&
          event.logicalKey == LogicalKeyboardKey.backspace &&
          rightInputController.text.isEmpty) {
        leftInputFocusNode.requestFocus();
        return KeyEventResult.handled;
      }
      return KeyEventResult.ignored;
    };
  }

  @override
  void dispose() {
    leftInputController.dispose();
    rightInputController.dispose();
    leftInputFocusNode.dispose();
    rightInputFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello TextField!'),
      ),
      body: SafeArea(
        child: Center(
          child: Row(
            children: [
              const SizedBox(width: 20),
              Expanded(
                child: TextField(
                  controller: leftInputController,
                  focusNode: leftInputFocusNode,
                  onEditingComplete: () {
                    rightInputFocusNode.requestFocus();
                  },
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: TextField(
                  controller: rightInputController,
                  focusNode: rightInputFocusNode,
                  onEditingComplete: () {
                    leftInputFocusNode.requestFocus();
                  },
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),
        ),
      ),
    );
  }
}
