import 'package:flutter/material.dart';
import 'package:pharmacy/main.dart';
import 'package:pharmacy/screens/share/app_bar.dart';

class Config extends StatelessWidget {
  const Config({super.key});
  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: customAppBar('config', navigatorKey),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: const Center(child: Text("Configurações."))
      );
    }
}