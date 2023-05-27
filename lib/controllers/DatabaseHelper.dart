import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._();
  static Database? _database;

  DatabaseHelper._();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    // Get the application documents directory
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'QrCollection.db');

    // Open/create the database at a given path
    return await openDatabase(path, version: 2, onCreate: _createTables);
  }

  static String qrtablename = "qrcodes";
  static String qrcode = "qrcode";
  static String qrdate = "date";
  static String mainid = "id";

  Future<void> _createTables(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $qrtablename (
        $mainid INTEGER PRIMARY KEY AUTOINCREMENT,
        $qrcode TEXT,
        $qrdate TEXT
      )
    ''');
  }

  Future<int> insertqrcode({String? lqrcode, String? lqrdate}) async {
    final db = await database;

    return await db.rawInsert(
        'INSERT INTO $qrtablename'
        '($qrcode, $qrdate) '
        'VALUES(?, ?)',
        [lqrcode, lqrdate]);
  }

  Future<int> getqrdatalength() async {
    final db = await database;
    var response = await db.query('$qrtablename');
    var count = response.length;
    return count;
  }

  Future<List<Map<String, dynamic>>> getalllocalqrdata() async {
    final db = await database;
    return await db.query('$qrtablename');
  }

  Future<int> deleteAlllocalQrdata() async {
    Database db = await instance.database;
    return await db.rawDelete('DELETE FROM $qrtablename WHERE id > 0');
  }
}

class qrdatamodel {
  String? qrcode;
  dynamic date;
  qrdatamodel({this.qrcode, this.date});
}
