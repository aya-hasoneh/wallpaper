import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:wallpaper_app/constant/favorite_fields.dart';
import 'package:wallpaper_app/model/wallpaper_model.dart';

class FavoriteDatabase {
  static final FavoriteDatabase instance = FavoriteDatabase._init();

  FavoriteDatabase._init();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('favorite.db');
    return _database!;
  }

  /// Initialize database
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  ///  Creating database
  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $tableFavorite ( 
      ${FavoriteFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${FavoriteFields.src} TEXT,
      ${FavoriteFields.srcLarge} TEXT,
      ${FavoriteFields.medium} TEXT,
      ${FavoriteFields.large} TEXT,
      ${FavoriteFields.tiny} TEXT,
      ${FavoriteFields.original} TEXT,
      ${FavoriteFields.large2x} TEXT,
      ${FavoriteFields.portrait} TEXT,
      ${FavoriteFields.small} TEXT,
      ${FavoriteFields.landscape} TEXT
      
    )
  ''').catchError((error) => print('this error ${error.toString()}'));
  }

  Future<Photos> create({required Photos photo}) async {
    final db = await instance.database;
    final id = await db.insert(tableFavorite, photo.toJson());
    return photo.copyWith(id: id);
  }

  Future<Photos> readFavorite(int id) async {
    final db = await instance.database;
    final map = await db.query(tableFavorite,
      columns: FavoriteFields.values,
      where: '${FavoriteFields.id} = ?',
      whereArgs: [id],
    );
    if (map.isNotEmpty) {
      return Photos.fromJson(map.first);
    } else {
      throw Exception('not found');
    }



  }
  Future <List<Photos>>readAllFavorite()async{
    final db = await instance.database;
    final result = await db.query(tableFavorite,
    );
    return result.map((json)=>Photos.fromJson(json)).toList();
  }
  Future <int> delete(int id)async{
    final db = await instance.database;
    return await db.delete(tableFavorite,
      where: '${FavoriteFields.id} = ?',
      whereArgs: [id],
    );
  }
  Future closeDB() async {
    var db = await instance.database;
    db.close();
  }

}