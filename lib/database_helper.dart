import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDatabase();
    return _db!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'hall_dining.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT UNIQUE,
        password TEXT,
        credits INTEGER,
        tokens INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE menu(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT UNIQUE,
        lunch TEXT,
        dinner TEXT
      )
    ''');
  }

  Future<void> insertUser({
    required String username,
    required String password,
    required int credits,
    required int tokens,
  }) async {
    final db = await database;
    await db.insert('users', {
      'username': username,
      'password': password,
      'credits': credits,
      'tokens': tokens,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Map<String, dynamic>?> getUser(String username) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'username = ?',
      whereArgs: [username],
    );
    return result.isNotEmpty ? result.first : null;
  }

  Future<void> updateUserTokens(
    String username,
    int tokens,
    int credits,
  ) async {
    final db = await database;
    await db.update(
      'users',
      {'tokens': tokens, 'credits': credits},
      where: 'username = ?',
      whereArgs: [username],
    );
  }

  Future<void> setMenuForToday(String lunch, String dinner) async {
    final db = await database;
    final now = DateTime.now();
    final date =
        "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

    final existing = await db.query(
      'menu',
      where: 'date = ?',
      whereArgs: [date],
    );

    if (existing.isNotEmpty) {
      await db.update(
        'menu',
        {'lunch': lunch, 'dinner': dinner},
        where: 'date = ?',
        whereArgs: [date],
      );
    } else {
      await db.insert('menu', {'date': date, 'lunch': lunch, 'dinner': dinner});
    }
  }

  Future<Map<String, dynamic>?> getMenuForToday() async {
    final db = await database;
    final now = DateTime.now();
    final date =
        "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

    final result = await db.query('menu', where: 'date = ?', whereArgs: [date]);
    return result.isNotEmpty ? result.first : null;
  }
}
