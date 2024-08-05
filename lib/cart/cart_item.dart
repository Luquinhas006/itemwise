import 'package:pharmacy/products/product.dart';

class CartItem {
  int? id;
  int cartId;
  int productId;
  int quantity;
  late Product? product;

  CartItem({
        this.id
      , required this.cartId
      , required this.productId
      , required this.quantity
  });

  double get total {
    if (product != null) {
      return product!.unitPrice * quantity;
    }
    return 0;
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'cartId': cartId,
      'productId': productId,
      'quantity': quantity,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'],
      cartId: map['cartId'],
      productId: map['productId'],
      quantity: map['quantity']
    );
  }
}
