import 'package:flutter/material.dart';
import 'package:pharmacy/cart/cart.dart';
import 'package:pharmacy/cart/cart_item.dart';
import 'package:pharmacy/database/database_helper.dart';
import 'package:pharmacy/products/product.dart';

class CartProvider extends ChangeNotifier {
  final DatabaseHelper _databaseHelper;
  final int _cartId;
  Cart? _myCart;
  
  Cart? get currentCart {
    if (_myCart == null) {
      _loadCart();
    }
    return _myCart;
  }

  CartProvider(this._databaseHelper, this._cartId) {
    _loadCart();
  }

  Future<void> _loadCart() async {
    _myCart = await _databaseHelper.getCartById(_cartId);
    notifyListeners();
  }

  Future<bool> isCartEmpty() async {
    var cart = await getCart(_cartId);
    if (cart == null) return true;
    if (cart.items.isEmpty) return true;
    return false;
  }

  Future<Cart?> getCart(int id) async {
    Cart? cart = await _databaseHelper.getCartById(id);
    if (cart == null) return null;
    cart.items = await _databaseHelper.getCartItems(cart.id!);
    return cart;
  }

  Future<void> addItem(Product product, int quantity) async {
    List<CartItem> items = await _databaseHelper.getCartItems(_cartId);
    for (CartItem item in items) {
      if (item.productId == product.id) {
        item.product ??= await _databaseHelper.getProductById(item.productId);
        item.quantity += quantity;
        await _databaseHelper.updateCartItem(item);
        await _loadCart();
        notifyListeners();
        return;
      }
    }
    await _databaseHelper.insertCartItem(_cartId, product, quantity);
    await _loadCart();
    notifyListeners();
  }

  Future<bool> containsByProductId(int productId) async {
    List<CartItem> items = await _databaseHelper.getCartItems(_cartId);
    for (CartItem item in items){
      if (item.productId == productId) {
        return true;
      }
    }
    return false;
  }

  Future<int> getQuantity(int productId) async {
    List<CartItem> items = await _databaseHelper.getCartItems(_cartId);
    for (CartItem item in items){
      if (item.productId == productId) {
        return item.quantity;
      }
    }
    return 0;
  }

  Future<void> removeItemByProductId(int productId)  async {
    CartItem? cartItem = await _databaseHelper.getCartItemByProductId(_cartId, productId);
    if (cartItem != null) {
      await _databaseHelper.deleteCartItem(cartItem.id!);
      await _loadCart();
      notifyListeners();
    }
  }

  Future<void> decreaseItem(Product product, int quantity) async {
    List<CartItem> items = await _databaseHelper.getCartItems(_cartId);
    for (CartItem item in items) {
      if (item.productId == product.id) {
        if ((item.quantity - quantity) > 0) {
          item.product ??= await _databaseHelper.getProductById(item.productId);
          item.quantity -= quantity;
          await _databaseHelper.updateCartItem(item);
          await _loadCart();
          notifyListeners();
        }
      }
    }
  }
}
