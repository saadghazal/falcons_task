import 'dart:io';

import 'package:falcons_task/errors/exceptions.dart';
import 'package:falcons_task/models/item.dart';
import 'package:falcons_task/models/item_quantity.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class LocalStorageService {
  String databaseName = "sales.db";
  Database? _database;

  Future<Database> get database async {
    if (_database == null) {
      await _initOrOpenDatabase();
    }
    return _database!;
  }

  Future<void> _initOrOpenDatabase() async {
    final databasePath = await getDatabasesPath();
    final String path = join(databasePath, databaseName);

    print("Initializing or Opening DB");
    _database = await openDatabase(path, version: 1, onCreate: (db, versions) async {
      await db.execute("CREATE TABLE Item(item_id INT PRIMARY KEY, item_name TEXT, quantity TEXT)");
      await db.execute("CREATE TABLE ItemData(ITEMNO INT PRIMARY KEY, NAME TEXT)");
      await db.execute("CREATE TABLE ItemQuantity(ItemOCode INT PRIMARY KEY, QTY TEXT)");
    });
  }

  Future<void> storeItem(Item item) async {
    var db = await database;
    await db.rawInsert(
        "INSERT OR REPLACE INTO ItemData(ITEMNO,NAME) VALUES(?,?)", [item.itemno, item.name]);
  }

  Future<void> storeQuantity(ItemQuantity itemQuantity) async {
    var db = await database;
    await db.rawInsert("INSERT OR REPLACE INTO ItemQuantity(ItemOCode,QTY) VALUES(?,?)",
        [itemQuantity.itemOCode, itemQuantity.qty]);
  }

  Future<void> storeMergedDataInDB() async {
    var db = await database;
    await db.rawInsert(
        "INSERT OR REPLACE INTO Item(item_id,item_name,quantity) SELECT i.ITEMNO,i.NAME,q.QTY FROM ItemData as i INNER JOIN ItemQuantity as q on i.ITEMNO = q.ItemOCode");
  }

  Future<List<Map<String, Object?>>> getStoredData() async {
    try {
      var db = await database;
      return await db.rawQuery("SELECT * FROM Item");
    } catch (e) {
      throw LocalStorageException(message: "Error Getting Stored Data SQL");
    }
  }

  Future<bool> isDBExist() async {
    final databasePath = await getDatabasesPath();
    final String path = join(databasePath, databaseName);
    File dbFile = File(path);
    return dbFile.existsSync();
  }
}
