import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterBoot Day07',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const HelloOverlay(),
    );
  }
}

class HelloOverlay extends StatefulWidget {
  const HelloOverlay({super.key});

  @override
  State<HelloOverlay> createState() => _HelloOverlay();
}

class _HelloOverlay extends State<HelloOverlay> {
  bool overlayVisible = false;
  OverlayEntry? overlayEntry;
  final List<String> _buttons = ['Hello!', 'Press', 'any', 'button!'];
  List<GlobalKey> _buttonKeys = [];

  @override
  void initState() {
    super.initState();
    _buttonKeys = _buttons.map((_) => GlobalKey()).toList();
  }

  void showOverlay(Offset buttonOffset, double buttonWidth) {
    removeOverlay();

    assert(overlayEntry == null);

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: buttonOffset.dy - 25,
        left: buttonOffset.dx + buttonWidth / 2,
        child: IgnorePointer(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade500,
              borderRadius: BorderRadius.circular(4),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: const Text(
              '↓ You clicked this 😎',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry!);
    setState(() {
      overlayVisible = true;
    });
  }

  Widget overlayButton(String buttonName, GlobalKey buttonKey) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      width: double.infinity,
      child: ElevatedButton(
        key: buttonKey,
        onPressed: () {
          RenderBox renderBox =
              buttonKey.currentContext!.findRenderObject() as RenderBox;
          Offset offset = renderBox.localToGlobal(Offset.zero);
          showOverlay(offset, renderBox.size.width);
        },
        child: Text(
          buttonName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  void removeOverlay() {
    if (overlayEntry != null) {
      overlayEntry?.remove();
      overlayEntry?.dispose();
      overlayEntry = null;
      setState(() {
        overlayVisible = false;
      });
    }
  }

  @override
  void dispose() {
    removeOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (overlayVisible) {
          removeOverlay();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Hello Overlay'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 16.0,
            ),
            ...List.generate(
              _buttons.length,
              (index) => overlayButton(_buttons[index], _buttonKeys[index]),
            ),
          ],
        ),
      ),
    );
  }
}
