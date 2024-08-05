import 'dart:io';

import 'package:pharmacy/cart/cart.dart';
import 'package:pharmacy/cart/cart_item.dart';
import 'package:pharmacy/products/product.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  Database? _database;

  Future<void> init() async {
    _database = await _initDatabase();
  }

  Future<Database> get database async {
    if (_database == null) {
      await init();
    }
    return _database!;
  }

  Future<Database> _initDatabase() async {
    await deleteDatabaseFile();
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'pharmacyAppDatabase.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }
  
  Future<void> _onCreate(Database db, int version) async {

    await db.execute('''
      CREATE TABLE Product(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        subtitle TEXT NOT NULL,
        image TEXT NOT NULL,
        unitPrice DOUBLE
      )
    ''');

    await db.execute('''
      CREATE TABLE Cart(
        id INTEGER PRIMARY KEY AUTOINCREMENT
      )
    ''');

    await db.execute('''
      CREATE TABLE CartItem(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        cartId INTEGER,
        productId INTEGER,
        quantity INTEGER,
        total DOUBLE,
        FOREIGN KEY (cartId) REFERENCES Cart(id)
        FOREIGN KEY (productId) REFERENCES Product(id)
      )
    ''');
  }

    // Method to delete the database file
  Future<void> deleteDatabaseFile() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final path = join(directory.path, 'pharmacyAppDatabase.db');
      final file = File(path);

      if (await file.exists()) {
        await file.delete(); 
        print('Database deleted successfully.');
      } else {
        print('Database file does not exist.');
      }
      _database = null; // Ensure the database is closed and set to null
    } catch (e) {
      print('Error deleting database: $e');
    }
  }


  // PRODUTO
  Future<List<Product>> getProducts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('Product');
    return List.generate(maps.length, (i) {
      return Product.fromMap(maps[i]);
    });
  }
  Future<int> countProducts() async {
    var products = await getProducts();
    return products.length;
  }
  Future<void> initProductDatabase() async {
    if (await countProducts() > 0) { return; }
    await insertProduct(Product(id: 1, name: 'Aspirina', image: 'assets/images/aspirina.png', subtitle: 'Alívio da Dor', unitPrice: 10.59));
    await insertProduct(Product(id: 2, name: 'Novalgina', image: 'assets/images/novalgina.png', subtitle: 'Alívio da Dor', unitPrice: 23));
    await insertProduct(Product(id: 3, name: 'Energil C', image: 'assets/images/energilc.png', subtitle: 'Vitamina C', unitPrice: 20.69));
    await insertProduct(Product(id: 4, name: 'Dorflex', image: 'assets/images/dorflex.png', subtitle: 'Alívio da Dor', unitPrice: 22.52));
    await insertProduct(Product(id: 5, name: 'Ivermectina', image: 'assets/images/ivermectina.png', subtitle: 'Antiparasitário', unitPrice: 16.81));
  }
  Future<int> insertProduct(Product product) async {
    final db = await database;
    return await db.insert('Product', product.toMap());
  }
  Future<int> updateProduct(Product product) async {
    final db = await database;
    return await db.update(
      'Product',
      product.toMap(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }
  Future<int> deleteProduct(int id) async {
    final db = await database;
    return await db.delete(
      'Product',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  Future<Product?> getProductById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'Product',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Product.fromMap(maps.first);
    } else {
      return null;
    }
  }

  // CARRINHO
  Future<List<Cart>> getCarts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('Cart');
    return List.generate(maps.length, (i) {
      return Cart.fromMap(maps[i]);
    });
  }
  Future<int> insertCart(Cart cart) async {
    final db = await database;
    return await db.insert('Cart', cart.toMap(), nullColumnHack: 'id');
  }
  Future<int> updateCart(Cart cart) async {
    final db = await database;
    return await db.update(
      'Cart',
      cart.toMap(),
      where: 'id = ?',
      whereArgs: [cart.id],
    );
  }
  Future<int> deleteCart(int id) async {
    final db = await database;
    return await db.delete(
      'Cart',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  Future<Cart?> getCartById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'Cart',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      var cart = Cart.fromMap(maps.first);
      cart.items = await getCartItems(cart.id!);
      return cart;
    } else {
      return null;
    }
  }

// ITENS DE CARRINHO
  Future<List<CartItem>> getCartItems(int cartId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'CartItem',
      where: 'cartId = ?',
      whereArgs: [cartId],
    );
    List<Future<CartItem>> futures = List.generate(maps.length, (i) async {
      var cartItem = CartItem.fromMap(maps[i]);
      cartItem.product = await getProductById(cartItem.productId);
      return cartItem;
    });

    return await Future.wait(futures);
  }
  Future<int> insertCartItem(int cartId, Product product, int quantity) async {
    final db = await database;
    return await db.insert('CartItem', CartItem(cartId: cartId, productId: product.id!, quantity: quantity).toMap());
  }
  Future<int> updateCartItem(CartItem cartItem) async {
    final db = await database;
    return await db.update(
      'CartItem',
      cartItem.toMap(),
      where: 'id = ?',
      whereArgs: [cartItem.id],
    );
  }
  Future<int> deleteCartItem(int id) async {
    final db = await database;
    return await db.delete(
      'CartItem',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  Future<CartItem?> getCartItemById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'CartItem',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return CartItem.fromMap(maps.first);
    } else {
      return null;
    }
  }
  Future<CartItem?> getCartItemByProductId(int cartId, int productId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'CartItem',
      where: 'cartId = ? AND productId = ?',
      whereArgs: [cartId, productId],
    );
    if (maps.isNotEmpty) {
      return CartItem.fromMap(maps.first);
    } else {
      return null;
    }
  }
}