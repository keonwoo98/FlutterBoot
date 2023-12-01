import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyListView(),
    );
  }
}

class MyListView extends StatelessWidget {
  final List<String> spaceDataKeys = [
    'NGC 162',
    '87 Sylvia',
    'R 136a1',
    '28978 Ixion',
    'NGC 6715',
    '94400 Hongdaeyong',
    '6354 Vangelis',
    'C/2020 F3',
    'Cartwheel Galaxy',
    'Sculptor Dwarf Elliptical Galaxy',
    'Eight-Burst Nebula',
    'Rhea',
    'C/1702 H1',
    'Messier 5',
    'Messier 50',
    'Cassiopeia A',
    'Great Comet of 1680',
    'Butterfly Cluster',
    'Triangulum Galaxy',
    'Comet of 1729',
    'Omega Nebula',
    'Eagle Nebula',
    'Small Sagittarius Star Cloud',
    'Dumbbell Nebula',
    '54509 YORP',
    'Dia',
    '63145 Choemuseon',
  ];

  final Map<String, int> spaceData = {
    'NGC 162': 1862,
    '87 Sylvia': 1866,
    'R 136a1': 1985,
    '28978 Ixion': 2001,
    'NGC 6715': 1778,
    '94400 Hongdaeyong': 2001,
    '6354 Vangelis': 1934,
    'C/2020 F3': 2020,
    'Cartwheel Galaxy': 1941,
    'Sculptor Dwarf Elliptical Galaxy': 1937,
    'Eight-Burst Nebula': 1835,
    'Rhea': 1672,
    'C/1702 H1': 1702,
    'Messier 5': 1702,
    'Messier 50': 1711,
    'Cassiopeia A': 1680,
    'Great Comet of 1680': 1680,
    'Butterfly Cluster': 1654,
    'Triangulum Galaxy': 1654,
    'Comet of 1729': 1729,
    'Omega Nebula': 1745,
    'Eagle Nebula': 1745,
    'Small Sagittarius Star Cloud': 1764,
    'Dumbbell Nebula': 1764,
    '54509 YORP': 2000,
    'Dia': 2000,
    '63145 Choemuseon': 2000,
  };

  MyListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My first ListView!'),
      ),
      body: MyListViewWidget(spaceDataKeys, spaceData),
    );
  }
}

class MyListViewWidget extends StatelessWidget {
  final List<String> spaceDataKeys;
  final Map<String, int> spaceData;
  final ScrollController _scrollController = ScrollController();

  MyListViewWidget(this.spaceDataKeys, this.spaceData, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        controller: _scrollController,
        itemCount: spaceDataKeys.length,
        itemBuilder: (context, index) {
          final key = spaceDataKeys[index];
          final value = spaceData[key];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 0.6,
                ),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.network_check_sharp),
                      const SizedBox(width: 8.0),
                      Text('$key was discovered in $value'),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _scrollController.animateTo(
            0.0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        },
        child: const Icon(Icons.arrow_upward),
      ),
    );
  }
}
