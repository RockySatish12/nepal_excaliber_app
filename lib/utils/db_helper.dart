import 'dart:developer';

import 'package:sqflite/sqflite.dart';

import '../models/cart.dart';

class DatabaseHelper {
  static String DB_NAME = "cart_db.db";
  static String cart_table = "cart";
  static Database? _db;

  Future<Database> getDb() async {
    log("get db");
    if (_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }

  initDb() async {
    print("iniatialize db");
    var databasesPath = await getDatabasesPath();
    String path = "$databasesPath/$DB_NAME";
    _db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return _db;
  }

  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute("""CREATE TABLE $cart_table(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    product_id INTEGER NOT NULL,
    product_title TEXT NOT NULL,
    product_price DOUBLE NOT NULL,
    quantity INTEGER NOT NULL,
    image_url TEXT NOT NULL,
    category TEXT NOT NULL,
    sizes TEXT,
    color TEXT,
    has_Offer BOOLEAN NOT NULL,discount INTEGER)""");
    log("Tables created");
  }

  Future<Cart?> getCartItem(String whereString, List<String> args) async {
    try {
      var results =
          await _db!.query(cart_table, where: whereString, whereArgs: args);
      if (results.isEmpty) return null;
      var cartItem = Cart.fromJson(results[0]);
      return cartItem;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<void> saveToCart(Cart cart) async {
    log("saving");
    var result = await _db!.insert(cart_table, cart.toJson());
    log("Saved");
  }

  Future<List<Cart>> getCartItems() async {
    try {
      var results = await _db!.query(cart_table);
      log(results.toString());
      var cartItems = cartsFromJson(results);
      return cartItems;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  Future<int> updateCartItem(Cart cart) async {
    var result = await _db!.update(cart_table, cart.toJson(),
        where: "id = ?", whereArgs: [cart.id]);
    return result;
  }

  Future<bool> delete(int id) async {
    var result = await _db!.rawDelete("DELETE FROM $cart_table WHERE id = $id");
    return result == 1;
  }
}
