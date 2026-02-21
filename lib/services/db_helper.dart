import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDB();
    }
    return _database!;
  }

  initDB() async {
    String path = join(await getDatabasesPath(), "bank.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            "CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, email TEXT, balance REAL)");

        await db.execute(
            "CREATE TABLE transfers(id INTEGER PRIMARY KEY AUTOINCREMENT, sender TEXT, receiver TEXT, amount REAL)");

       
        for (int i = 1; i <= 10; i++) {
          await db.insert("users", {
            "name": "User $i",
            "email": "user$i@email.com",
            "balance": 1000
          });
        }
      },
    );
  }

  getUsers() async {
    Database db = await database;
    return await db.query("users");
  }

  transfer(int fromId, int toId, double amount) async {
    Database db = await database;

    List users = await db.query("users");

    var fromUser = users.firstWhere((u) => u["id"] == fromId);
    var toUser = users.firstWhere((u) => u["id"] == toId);

    double fromBalance = fromUser["balance"];
    double toBalance = toUser["balance"];

    if (fromBalance >= amount) {
      await db.update(
        "users",
        {"balance": fromBalance - amount},
        where: "id=?",
        whereArgs: [fromId],
      );

      await db.update(
        "users",
        {"balance": toBalance + amount},
        where: "id=?",
        whereArgs: [toId],
      );

      await db.insert("transfers", {
        "sender": fromUser["name"],
        "receiver": toUser["name"],
        "amount": amount
      });
    }
  }
}
