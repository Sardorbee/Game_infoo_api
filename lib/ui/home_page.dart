import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dars/ui/details_page.dart';
import 'package:dars/ui/search.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:http/http.dart' as http;
import '../services/network/dio.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List<dynamic> alldata = [];

  Future<void> fetchData() async {
    final url = Uri.parse('https://www.freetogame.com/api/games');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      // Check the data structure and adjust the index accordingly
      final results = data;

      // Ensure that 'results' is an iterable structure like a list or map
      if (results is List) {
        setState(() {
          alldata = List<dynamic>.from(results);
        });
      }
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(alldata);
    return Scaffold(
      
      appBar: AppBar(
        title: const Text("Games"),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(
                  alldata,
                ),
              );
            },
            icon: const Icon(
              Icons.search,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          8,
        ),
        child: FutureBuilder(
          future: GameServices.fetchdata(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // Box box = Hive.box('games');
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final gamedata = snapshot.data;
              // return _buildContactList(contacts!, context);
              if (gamedata.isEmpty) {
                return const Center(
                  child: Text(
                    "You have no games yet",
                    style: TextStyle(color: Colors.black38, fontSize: 16),
                  ),
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CarouselSlider.builder(
                        carouselController: CarouselController(),
                        itemCount: gamedata.length,
                        itemBuilder: (context, index, realIndex) {
                          final game = gamedata[index];
                          return Padding(
                            padding: const EdgeInsets.all(8),
                            child: ZoomTapAnimation(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DetailsPage(game: game),
                                  ),
                                );
                              },
                              child: CachedNetworkImage(
                                imageUrl: game.thumbnail,
                              ),
                            ),
                          );
                        },
                        options: CarouselOptions(
                          enableInfiniteScroll: true,
                          autoPlay: true,
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "All Games",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: gamedata.length,
                        itemBuilder: (BuildContext context, int index) {
                          final gamee = gamedata[index];
                          return ListTile(
                            leading: CachedNetworkImage(
                              height: 80,
                              width: 80,
                              imageUrl: gamee.thumbnail,
                            ),
                            title: Text(gamee.title.toString()),
                            subtitle: Text(gamee.developer.toString()),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailsPage(game: gamee),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
            }
          },
        ),
      ),
    );
  }
}
