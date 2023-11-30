import 'package:flutter/material.dart';

class Feature {
  final String name;
  final String description;
  final IconData icon;

  Feature({
    required this.name,
    required this.description,
    required this.icon,
  });
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterBoot Day01',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: FlutterBootPlus(),
    );
  }
}

class FlutterBootPlus extends StatelessWidget {
  FlutterBootPlus({super.key});

  final List<Feature> features = [
    Feature(
      name: 'Premium Feature',
      description:
          'Plus subscribers get access to FlutterBoot+ and latest beta features.',
      icon: Icons.flash_on,
    ),
    Feature(
      name: 'Priority Access',
      description:
          'You\'ll be able to access FlutterBoot+ even when demand is high',
      icon: Icons.fireplace,
    ),
    Feature(
      name: 'Ultra Fast',
      description: 'Enjoy even faster response speeds when using FlutterBoot',
      icon: Icons.auto_graph_sharp,
    ),
  ];

  Widget buildFeatureColumn(List<Feature> features) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: features
          .map((feature) => Column(
                children: [
                  Row(
                    children: [
                      Icon(feature.icon),
                      const SizedBox(width: 10.0),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              feature.name,
                              style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              feature.description,
                              style: const TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                ],
              ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'FlutterBoot Plus',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 40.0,
                  ),
                ),
                const SizedBox(height: 40.0),
                buildFeatureColumn(features),
              ],
            ),
            const Spacer(),
            Center(
              child: Column(
                children: [
                  const Text(
                    'Restore subscription',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Text(
                    'Auto-renews for \$25/month until canceled',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(16.0),
                      minimumSize: const Size(double.infinity, 12.0),
                    ),
                    child: const Text('Subscribe'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
