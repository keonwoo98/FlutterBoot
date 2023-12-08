import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterBoot Day09',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyRandomImageSlider(),
    );
  }
}

class MyRandomImageSlider extends StatefulWidget {
  const MyRandomImageSlider({super.key});

  @override
  State<MyRandomImageSlider> createState() => _MyRandomImageSliderState();
}

class _MyRandomImageSliderState extends State<MyRandomImageSlider> {
  late String currentImageSrc;
  bool isLoading = false;
  bool isError = false;
  final Map<String, Image> imageCache = {};
  List<String> imageList = [];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadNewImage();
  }

  String getRandomImageSrc() {
    return 'https://picsum.photos/id/${Random().nextInt(1000) + 1}/200/200';
  }

  Future<void> _loadNewImage() async {
    setState(() {
      isLoading = true;
      isError = false;
    });

    try {
      final String newImageSrc = getRandomImageSrc();

      if (imageCache.containsKey(newImageSrc)) {
        setState(() {
          currentImageSrc = newImageSrc;
          currentIndex = imageList.indexOf(newImageSrc);
        });
      } else {
        final response = await http.get(Uri.parse(newImageSrc));

        if (response.statusCode == 200) {
          imageCache[newImageSrc] = Image.network(newImageSrc);
          imageList.add(newImageSrc);
          currentIndex = imageList.indexOf(newImageSrc);
          setState(() {
            currentImageSrc = newImageSrc;
          });
        } else {
          setState(() {
            isError = true;
          });
        }
      }
    } catch (e) {
      setState(() {
        isError = true;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showPreviousImage() {
    if (currentIndex > 0) {
      currentIndex--;
      setState(() {
        currentImageSrc = imageList[currentIndex];
      });
    }
  }

  void _showNextImage() {
    if (currentIndex < imageList.length - 1) {
      currentIndex++;
      setState(() {
        currentImageSrc = imageList[currentIndex];
      });
    } else {
      _loadNewImage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Click left and right'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: isLoading ? null : _showPreviousImage,
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(100, 0),
                ),
                child: const Text(
                  '<',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ElevatedButton(
                onPressed: isLoading ? null : _showNextImage,
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(100, 0),
                ),
                child: const Text(
                  '>',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Expanded(
            child: isLoading
                ? const Center(child: Text('Loading...'))
                : isError
                    ? const Center(child: Text('Oops! Something went wrong.'))
                    : Image.network(
                        width: double.infinity,
                        currentImageSrc,
                        fit: BoxFit.fill,
                      ),
          ),
        ],
      ),
    );
  }
}
