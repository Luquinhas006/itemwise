import 'package:flutter/material.dart';
import 'package:pharmacy/database/cart_provider.dart';
import 'package:pharmacy/main.dart';
import 'package:pharmacy/screens/share/app_bar.dart';
import 'package:provider/provider.dart';

class ShoppingCart extends StatelessWidget {
  const ShoppingCart({super.key});
  @override
    Widget build(BuildContext context) {

      final cartProvider = Provider.of<CartProvider>(context);

      return Scaffold(
        appBar: customAppBar('carrinho', navigatorKey),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: cartProvider.currentCart!.isCartEmpty()
          ? const Center(child: Text("Carrinho vazio."),)
          : ListView.builder(
            itemCount: cartProvider.currentCart!.items.length,
            itemBuilder: (context, index) {
              final item = cartProvider.currentCart!.items[index];
              return ListTile(
                title: Text(item.product!.name),
                subtitle: Text('Quantidade: ${item.quantity}x | Total: R\$ ${item.total.toStringAsFixed(2)}'),
                leading: IconButton(
                  icon: const Icon(Icons.remove_shopping_cart),
                  onPressed: () {
                    cartProvider.removeItemByProductId(item.productId);
                  },
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.add_circle),
                      onPressed: () {
                        cartProvider.addItem(item.product!, 1);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.remove_circle),
                      onPressed: () {
                        if (cartProvider.currentCart!.getQuantity(item.productId) == 1){
                          cartProvider.removeItemByProductId(item.productId);
                        } else {
                          cartProvider.decreaseItem(item.product!, 1);
                        }
                      },
                    ),
                  ]
                ),
              );
            },
          )
      );
    }
}