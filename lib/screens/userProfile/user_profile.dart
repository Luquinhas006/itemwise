import 'package:flutter/material.dart';
import 'package:pharmacy/main.dart';
import 'package:pharmacy/screens/share/app_bar.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});
  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: customAppBar('profile', navigatorKey),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: const Center(child: Text("Perfil do Usuário."))
      );
    }
}