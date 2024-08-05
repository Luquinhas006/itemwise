import 'package:flutter/material.dart';
import 'package:pharmacy/cart/Cart.dart';
import 'package:pharmacy/main.dart';
import 'package:pharmacy/screens/share/custom_appbar.dart';
import 'package:provider/provider.dart';

class ShoppingCart extends StatelessWidget {
  const ShoppingCart({super.key});
  @override
    Widget build(BuildContext context) {
      final cart = Provider.of<Cart>(context);
      return Scaffold(
        appBar: customAppBar('carrinho', navigatorKey),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: cart.items.isEmpty
          ? Center(child: Text("Carrinho vazio."),)
          : ListView.builder(
            itemCount: cart.items.length,
            itemBuilder: (context, index) {
              final item = cart.items[index];
              return ListTile(
                title: Text(item.product.name),
                subtitle: Text('Quantidade: ${item.quantity}x | Total: R\$ ${item.total.toStringAsFixed(2)}'),
                leading: IconButton(
                  icon: Icon(Icons.remove_shopping_cart),
                  onPressed: () {
                    cart.removeItem(item.product);
                  },
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.add_circle),
                      onPressed: () {
                        cart.addItem(item.product, 1);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.remove_circle),
                      onPressed: () {
                        if (cart.getQuantity(item.product.name) == 1){
                          cart.removeItem(item.product);
                        } else {
                          cart.decreaseItem(item.product, 1);
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