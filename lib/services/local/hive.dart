import 'package:hive/hive.dart';

class HiveService {
  static  Box? box;

  static openbox() async {
    box = await Hive.openBox('games');
  }
}
