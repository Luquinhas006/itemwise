import 'package:flutter/material.dart';
import 'package:pharmacy/main.dart';
import 'package:pharmacy/screens/share/app_bar.dart';
import 'package:pharmacy/lists/list_custom.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  @override
    Widget build(BuildContext context) {
    var produtos = const ListCustom();
    return Scaffold(
      appBar: customAppBar('', navigatorKey),
      backgroundColor: const Color.fromARGB(255, 3, 44, 78),
      body: produtos,
    );
  }
}