// To parse this JSON data, do
//
//     final gameService = gameServiceFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';
part 'game_model.g.dart';

List<GameService> gameServiceFromJson(String str) => List<GameService>.from(
    json.decode(str).map((x) => GameService.fromJson(x)));

String gameServiceToJson(List<GameService> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 1)
class GameService {
  @HiveField(0)
  int id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String thumbnail;
  @HiveField(3)
  String shortDescription;
  @HiveField(4)
  String gameUrl;
  @HiveField(5)
  Genre genre;
  @HiveField(6)
  Platform platform;
  @HiveField(7)
  String publisher;
  @HiveField(8)
  String developer;
  @HiveField(9)
  String releaseDate;
  @HiveField(10)
  String freetogameProfileUrl;
  
  GameService({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.shortDescription,
    required this.gameUrl,
    required this.genre,
    required this.platform,
    required this.publisher,
    required this.developer,
    required this.releaseDate,
    required this.freetogameProfileUrl,
  });

  factory GameService.fromJson(Map<String, dynamic> json) => GameService(
        id: json["id"],
        title: json["title"],
        thumbnail: json["thumbnail"],
        shortDescription: json["short_description"],
        gameUrl: json["game_url"],
        genre: genreValues.map[json["genre"]]!,
        platform: platformValues.map[json["platform"]]!,
        publisher: json["publisher"],
        developer: json["developer"],
        releaseDate: json["release_date"],
        freetogameProfileUrl: json["freetogame_profile_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "thumbnail": thumbnail,
        "short_description": shortDescription,
        "game_url": gameUrl,
        "genre": genreValues.reverse[genre],
        "platform": platformValues.reverse[platform],
        "publisher": publisher,
        "developer": developer,
        "release_date": releaseDate,
        "freetogame_profile_url": freetogameProfileUrl,
      };
}

enum Genre {
  SHOOTER,
  MMOARPG,
  ARPG,
  STRATEGY,
  MMORPG,
  FIGHTING,
  ACTION_RPG,
  BATTLE_ROYALE,
  MOBA,
  SPORTS,
  RACING,
  CARD_GAME,
  MMO,
  SOCIAL,
  GENRE_MMORPG,
  FANTASY
}

final genreValues = EnumValues({
  "Action RPG": Genre.ACTION_RPG,
  "ARPG": Genre.ARPG,
  "Battle Royale": Genre.BATTLE_ROYALE,
  "Card Game": Genre.CARD_GAME,
  "Fantasy": Genre.FANTASY,
  "Fighting": Genre.FIGHTING,
  " MMORPG": Genre.GENRE_MMORPG,
  "MMO": Genre.MMO,
  "MMOARPG": Genre.MMOARPG,
  "MMORPG": Genre.MMORPG,
  "MOBA": Genre.MOBA,
  "Racing": Genre.RACING,
  "Shooter": Genre.SHOOTER,
  "Social": Genre.SOCIAL,
  "Sports": Genre.SPORTS,
  "Strategy": Genre.STRATEGY
});

enum Platform { PC_WINDOWS, WEB_BROWSER, PC_WINDOWS_WEB_BROWSER }

final platformValues = EnumValues({
  "PC (Windows)": Platform.PC_WINDOWS,
  "PC (Windows), Web Browser": Platform.PC_WINDOWS_WEB_BROWSER,
  "Web Browser": Platform.WEB_BROWSER
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
