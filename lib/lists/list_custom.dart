import 'package:flutter/material.dart';
import 'package:pharmacy/database/cart_provider.dart';
import 'package:pharmacy/database/product_provider.dart';
import 'package:pharmacy/products/product.dart';
import 'package:provider/provider.dart';

class ListCustom extends StatelessWidget {
  const ListCustom({super.key});
  @override
  Widget build(BuildContext context) {

    final productProvider = Provider.of<ProductProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    List<Product> products = productProvider.products;
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            clipBehavior: Clip.antiAlias,
            child: Image.asset(products[index].image, height: 100, width: 100, fit: BoxFit.fill,),
          ) ,
          title: Text(
              (
                cartProvider.currentCart!.containsByProductId(products[index].id!)
                ? '${cartProvider.currentCart!.getQuantity(products[index].id!)}x | ${products[index].name}'
                : products[index].name
              )
              , style: const TextStyle(
                  fontSize: 16
                  , fontStyle: FontStyle.normal
                  , color: Color.fromARGB(255, 255, 255, 255)
              ),
          ),
          subtitle: Text(
              'R\$ ${products[index].unitPrice} | ${products[index].subtitle}'
              , style: const TextStyle(fontSize: 12
              , color: Color.fromARGB(255, 235, 235, 235)
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
          trailing: IconButton(
            icon: const Icon(Icons.add_shopping_cart_outlined, color: Colors.white),
            onPressed: () {
              cartProvider.addItem(products[index], 1);
            },
          )
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(
          thickness: 1
        );
      },
    );
  }
}