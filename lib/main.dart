import 'package:dars/services/local/hive.dart';
import 'package:dars/services/model/game_model.dart';
import 'package:dars/ui/home_page.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'cart-page.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(GameServiceAdapter());
  HiveService.openbox();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    Homescreen(),
    CartPage(), // Add the CartPage widget to the list of screens
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _screens[_currentIndex], // Use the selected screen based on currentIndex
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.crop_rotate_sharp,
              ),
              label: "Cart",
            ),
          ],
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index; // Update the currentIndex on tap
            });
          },
        ),
      ),
    );
  }
}
