import 'package:flutter/material.dart';
import 'package:pharmacy/screens/config/config.dart';
import 'package:pharmacy/screens/shoppingCart/shopping_cart.dart';
import 'package:pharmacy/screens/userProfile/user_profile.dart';

AppBar customAppBar(String appTitle, GlobalKey<NavigatorState> navigatorKey) {
  return AppBar(
    title: Text(appTitle),
    actions: [
      IconButton(
        color:  const Color.fromARGB(255, 0, 0, 0),
        onPressed: () {
          navigatorKey.currentState!.popUntil((route) => route.isFirst);
        },
        icon: const Icon(Icons.home),
      ),
      IconButton(
        color:  const Color.fromARGB(255, 0, 0, 0),
        onPressed: () {
          navigatorKey.currentState!.push(
            MaterialPageRoute(builder: (context) => const ShoppingCart())
          );
        },
        icon: const Icon(Icons.shopping_cart),
      ),
      PopupMenuButton(
        itemBuilder: (context) => [
          PopupMenuItem(
            child: const Text('Meu perfil'),
            onTap: () { 
              navigatorKey.currentState!.push(
                MaterialPageRoute(builder: (context) => const UserProfile())
              );
            },
          ),
          PopupMenuItem(
            child: const Text('Configurações'),
            onTap: () {
              navigatorKey.currentState!.push(
                MaterialPageRoute(builder: (context) => const Config())
              );
            },
          ),
        ],
      ),
      BottomAppBar(
        color:  const Color.fromARGB(255, 10, 93, 161),
        shape: const CircularNotchedRectangle(),
        notchMargin: 4.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              color: const Color.fromARGB(255, 255, 255, 255),
              onPressed: () {
                // Handle cart button press
                navigatorKey.currentState!.pop(true);
              },
            ),
          ]
        )
      )
    ]
  );
}
