import 'dart:convert';
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
      title: 'FlutterBoot Day08',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: const HelloHttp(),
    );
  }
}

class HelloHttp extends StatefulWidget {
  const HelloHttp({super.key});

  @override
  State<HelloHttp> createState() => _HelloHttpState();
}

class _HelloHttpState extends State<HelloHttp> {
  late TextEditingController _searchTextController;

  bool isLoading = false;
  FocusNode focusNode = FocusNode();
  List<Human> searchResults = [];
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    _searchTextController = TextEditingController(text: "sky");
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
      errorMessage = "";
    });

    try {
      final response = await http.get(Uri.parse(
          'https://swapi.dev/api/people/?search=${_searchTextController.text}'));

      if (response.statusCode == 200) {
        handleSuccessResponse(response);
      } else {
        handleApiError(response.statusCode);
      }
    } catch (error) {
      handleApiError(null);
    }
  }

  void handleSuccessResponse(http.Response response) {
    final people = People.fromJson(jsonDecode(response.body));

    setState(() {
      searchResults = people.results ?? [];
      isLoading = false;
    });

    if (searchResults.isEmpty) {
      setState(() {
        errorMessage =
            'No result found. Please try again with a different search term.';
      });
    }
  }

  void handleApiError(int? statusCode) {
    setState(() {
      isLoading = false;
      errorMessage = statusCode != null
          ? 'Failed to load data. Server returned status code: $statusCode'
          : 'Failed to load data. Please check your network connection.';
    });
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 28, 12, 0),
        child: Column(
          children: [
            SearchTextField(
              searchTextController: _searchTextController,
              focusNode: focusNode,
              onSearchPressed: fetchData,
            ),
            const SizedBox(height: 20),
            SearchResults(
              isLoading: isLoading,
              errorMessage: errorMessage,
              searchResults: searchResults,
            ),
          ],
        ),
      ),
    );
  }
}

class SearchTextField extends StatelessWidget {
  final TextEditingController searchTextController;
  final FocusNode focusNode;
  final VoidCallback onSearchPressed;

  const SearchTextField({
    super.key,
    required this.searchTextController,
    required this.focusNode,
    required this.onSearchPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextField(
        controller: searchTextController,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search, color: Colors.black),
          suffix: ElevatedButton(
            onPressed: onSearchPressed,
            child: const Text(
              'Search!',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          hintText: 'Enter the name of Star Wars character here!',
          border: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
        focusNode: focusNode,
      ),
    );
  }
}

class SearchResults extends StatelessWidget {
  final bool isLoading;
  final String errorMessage;
  final List<Human> searchResults;

  const SearchResults({
    super.key,
    required this.isLoading,
    required this.errorMessage,
    required this.searchResults,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading || searchResults.isEmpty) {
      return Expanded(
        child: Center(
          child: Text(
            isLoading ? 'Loading...' : errorMessage,
            textAlign: TextAlign.center,
          ),
        ),
      );
    } else if (searchResults.isNotEmpty) {
      return Expanded(
        child: ListView.builder(
          itemCount: searchResults.length,
          itemBuilder: (context, index) {
            final result = searchResults[index];
            return Card(
              color: Colors.grey.shade400,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
                side: const BorderSide(width: 2.0, color: Colors.black),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 4.0),
                  Text(
                    result.name ?? '',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${result.height} / '),
                      Text('${result.mass}')
                    ],
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Hair Color: ${result.hairColor} | '),
                      Text('Skin Color: ${result.skinColor}')
                    ],
                  ),
                  const SizedBox(height: 4.0),
                ],
              ),
            );
          },
        ),
      );
    }
    return Container();
  }
}

class People {
  int? count;
  String? next;
  int? previous;
  List<Human>? results;

  People({this.count, this.next, this.previous, this.results});

  People.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Human>[];
      json['results'].forEach((v) {
        results!.add(Human.fromJson(v));
      });
    }
  }
}

class Human {
  String? name;
  String? height;
  String? mass;
  String? hairColor;
  String? skinColor;
  String? eyeColor;
  String? birthYear;
  String? gender;
  String? homeworld;
  List<String>? films;
  List<String>? species;
  List<String>? vehicles;
  List<String>? starships;
  String? created;
  String? edited;
  String? url;

  Human({
    this.name,
    this.height,
    this.mass,
    this.hairColor,
    this.skinColor,
    this.eyeColor,
    this.birthYear,
    this.gender,
    this.homeworld,
    this.films,
    this.species,
    this.vehicles,
    this.starships,
    this.created,
    this.edited,
    this.url,
  });

  Human.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    height = json['height'];
    mass = json['mass'];
    hairColor = json['hair_color'];
    skinColor = json['skin_color'];
    eyeColor = json['eye_color'];
    birthYear = json['birth_year'];
    gender = json['gender'];
    homeworld = json['homeworld'];
    films = json['films'].cast<String>();
    species = json['species'].cast<String>();
    vehicles = json['vehicles'].cast<String>();
    starships = json['starships'].cast<String>();
    created = json['created'];
    edited = json['edited'];
    url = json['url'];
  }
}
