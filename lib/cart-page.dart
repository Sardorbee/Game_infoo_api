import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final box = Hive.box('games');
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(
          8,
        ),
      child: ListView(children: List.generate(box.length, (index) => ListTile(
        title: Text(box.get("game")),
      ))),),
      
    );
  }
}
