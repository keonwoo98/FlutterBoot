import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyLayout(),
    );
  }
}

class MyGridView extends StatelessWidget {
  const MyGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        children: [
          Container(
            color: Colors.grey[400],
          ),
          Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.blue,
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  color: Colors.white,
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.green,
                ),
              ),
            ],
          ),
          Container(
            color: Colors.white,
            child: Column(children: [
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                    child: Container(
                      color: Colors.yellowAccent,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.white,
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

class MyLayout extends StatelessWidget {
  const MyLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text(
            'I can layout this',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            const AspectRatio(
                aspectRatio: 1,
                child: Expanded(
                  child: MyGridView(),
                )),
            Expanded(
              child: Column(
                children: [
                  Flexible(
                    flex: 2,
                    child: Container(color: Colors.yellow),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(color: Colors.brown),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
