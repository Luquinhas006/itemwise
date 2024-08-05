import 'package:flutter/material.dart';
import 'package:pharmacy/screens/config/Config.dart';
import 'package:pharmacy/screens/home/home.dart';
import 'package:pharmacy/screens/shoppingCart/shoppingCart.dart';
import 'package:pharmacy/screens/userProfile/userProfile.dart';

AppBar customAppBar(String appTitle, GlobalKey<NavigatorState> navigatorKey) {
  return AppBar(
    title: Text(appTitle),
    actions: [
      IconButton(
        color:  Color.fromARGB(255, 0, 0, 0),
        onPressed: () {
          navigatorKey.currentState!.popUntil((route) => route.isFirst);
        },
        icon: const Icon(Icons.home),
      ),
      IconButton(
        color:  Color.fromARGB(255, 0, 0, 0),
        onPressed: () {
          navigatorKey.currentState!.push(
            MaterialPageRoute(builder: (context) => ShoppingCart())
          );
        },
        icon: const Icon(Icons.shopping_cart),
      ),
      PopupMenuButton(
        itemBuilder: (context) => [
          PopupMenuItem(
            child: Text('Meu perfil'),
            onTap: () { 
              navigatorKey.currentState!.push(
                MaterialPageRoute(builder: (context) => UserProfile())
              );
            },
          ),
          PopupMenuItem(
            child: Text('Configurações'),
            onTap: () {
              navigatorKey.currentState!.push(
                MaterialPageRoute(builder: (context) => Config())
              );
            },
          ),
        ],
      ),
      BottomAppBar(
        color:  Color.fromARGB(255, 10, 93, 161),
        shape: CircularNotchedRectangle(),
        notchMargin: 4.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app),
              color: Color.fromARGB(255, 255, 255, 255),
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
