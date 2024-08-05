import 'package:pharmacy/products/Product.dart';

class CartItem {
  Product product;
  int quantity;
  double total;

  CartItem({required this.product, required this.quantity})
    : total = quantity * product.unitPrice;
}
