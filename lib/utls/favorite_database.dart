
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:wallpaper_app/model/favorite_model.dart';



class FavoriteDatabase {
  static final FavoriteDatabase instance = FavoriteDatabase._int();
  static Database? dataBase;
  FavoriteDatabase._int();
  Future<Database> get database async {
    if (dataBase != null) return dataBase!;
    dataBase = await _initDB('favorite.db');
    return dataBase!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: createDB);
  }

  Future createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const imageUrlType = 'STRING NOT NULL';
    await db.execute('''
    CREATE TABLE $favoriteTable (
    ${FavoriteFields.id} $idType,
    ${FavoriteFields.imageUrl} $imageUrlType
    )
    '''
    );
  }

  Future<FavoriteModel> create(FavoriteModel favorite) async {
     final db = await instance.database;
    // final json = favorite.toJson();
    // final columns = '${FavoriteFields.imageUrl}';
    // final values = '${json[FavoriteFields.imageUrl]}';
    // final id = await db.rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');
    final id = await db.insert(favoriteTable, favorite.toJson());
    return favorite.copy(id: id);
  }
  Future <FavoriteModel>readFavorite(int id)async{
    final db = await instance.database;
final maps =await db.query(
  favoriteTable,
  columns:FavoriteFields.values,
  where: '${FavoriteFields.id} = ?',
    whereArgs: [id]
);
if(maps.isNotEmpty){
  return FavoriteModel.fromJson(maps.first);
}else{
  throw Exception('ID $id is not found');
}
  }

  Future<List<FavoriteModel>> readAllFavorite() async {
    final db = await instance.database;
    final result = await db.query(favoriteTable);
    return result.map((json) => FavoriteModel.fromJson(json)).toList();
  }
  Future <int> delete (int id)async{
    final db = await instance.database;
return await db.delete(favoriteTable,where: '${FavoriteFields.id} = ?',whereArgs: [id]);
  }
  Future closeDB() async {
    var db = await instance.database;
    db.close();
  }
}
