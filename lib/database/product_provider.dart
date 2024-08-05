import 'package:flutter/material.dart';
import 'package:pharmacy/database/database_helper.dart';
import 'package:pharmacy/products/product.dart';

class ProductProvider extends ChangeNotifier {
  final DatabaseHelper _databaseHelper;
  List<Product> _products = [];

  List<Product> get products => _products;

  ProductProvider(this._databaseHelper) {
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    _products = await _databaseHelper.getProducts();
    notifyListeners();
  }

  Future<Product?> getProduct(int id){
    return _databaseHelper.getProductById(id);
  }

  Future<void> addProduct(Product product) async {
    await _databaseHelper.insertProduct(product);
    await _loadProducts();
  }

  Future<void> updateProduct(Product product) async {
    await _databaseHelper.updateProduct(product);
    await _loadProducts();
  }

  Future<void> deleteProduct(int id) async {
    await _databaseHelper.deleteProduct(id);
    await _loadProducts();
  }
}
