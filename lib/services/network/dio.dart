import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

import '../model/game_model.dart';

class GameServices {
  static Future<List<GameService>?> fetchdata() async {
    Response response = await Dio().get('https://www.freetogame.com/api/games');
    if (response.statusCode == 200) {
      List<dynamic> data = response.data;
      return data.map((item) => GameService.fromJson(item)).toList();
    } else {
      throw Exception("Network Error");
    }
  }
}
