import 'package:cached_network_image/cached_network_image.dart';
import 'package:dars/services/local/hive.dart';
import 'package:dars/services/model/game_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/network/dio.dart';

class DetailsPage extends StatefulWidget {
  final GameService game;
  const DetailsPage({super.key, required this.game});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final box = Hive.box('games');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              box.put('game', widget.game.genre);
              
              
            },
            icon: const Icon(
              Icons.save,
            ),
          ),
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(
            8,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: widget.game.thumbnail,
              ),
              Text(
                widget.game.title,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        "Company: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(widget.game.publisher),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Genre: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(widget.game.genre.toString()),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Support Platforms: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(widget.game.platform.toString()),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Release Date: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(widget.game.releaseDate),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  RichText(
                    text: TextSpan(
                      text: "Description: ",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                            text: widget.game.shortDescription,
                            style:
                                const TextStyle(fontWeight: FontWeight.normal)),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      Future<void> urll(String phoneNumber) async {
                        final Uri launchUri = Uri(
                          scheme: 'https',
                          path: phoneNumber,
                        );
                        await launchUrl(launchUri);
                      }

                      urll(widget.game.gameUrl.substring(8));
                      print(widget.game.gameUrl);
                    },
                    child: const Text(
                      "Download This Game",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              )
            ],
          )),
    );
  }
}
