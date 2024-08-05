import 'package:flutter/material.dart';
import 'package:pharmacy/cart/cart_item.dart';

class Cart with ChangeNotifier {
  List<CartItem> items = [];
  int? id;

  Cart({
    this.id
  });

  bool containsByProductId(int productId){
    for (CartItem item in items){
      if (item.productId == productId) {
        return true;
      }
    }
    return false;
  }

  int getQuantity(int productId){
    for (CartItem item in items){
      if (item.productId == productId) {
        return item.quantity;
      }
    }
    return 0;
  }

  bool isCartEmpty() {
    return items.isEmpty;
  }

  double totalPrice() {
    return items.fold(0, (total, item) => total + item.total);
  }

  int totalItems() {
    return items.fold(0, (total, item) => total + item.quantity);
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      id: map['id'],
    );
  }
}