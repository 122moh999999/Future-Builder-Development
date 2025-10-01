import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';



class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'items.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE Items (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            phone TEXT NOT NULL,
            type TEXT NOT NULL,
            location TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<void> addItem(String phone,String type,String location) async {
    final db = await database;
    await db.insert('Items', {'phone': phone,'type':type,'location':location });
  }

  Future<List<Map<String, dynamic>>> getItems() async {
    final db = await database;
    return await db.query('Items');
  }

  Future<void> deleteItem(int id) async {
    final db = await database;
    await db.delete('Items', where: 'id = ?', whereArgs: [id]);
  }
}


