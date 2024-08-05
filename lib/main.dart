import 'package:flutter/material.dart';
import 'package:pharmacy/cart/cart.dart';
import 'package:pharmacy/database/cart_provider.dart';
import 'package:pharmacy/database/database_helper.dart';
import 'package:pharmacy/database/product_provider.dart';
import 'package:pharmacy/screens/home/home.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  final databaseHelper = DatabaseHelper();
  await databaseHelper.init();
  await databaseHelper.initProductDatabase();
  //inicializa um novo carrinho, e salva o ID como variavel Global
  Cart cart = Cart();
  cart.id = await databaseHelper.insertCart(cart);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<CartProvider>(
          create: (_) => CartProvider(databaseHelper, cart.id!),
        ),
        ChangeNotifierProvider<ProductProvider>(
          create: (_) => ProductProvider(databaseHelper),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Pharmacy",
      home: const Home(),
      navigatorKey: navigatorKey,
    );
  }
}