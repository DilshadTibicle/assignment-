import 'dart:convert';
import 'dart:io';
import 'package:goldenmovie/model/genre_item.dart';
import 'package:goldenmovie/response/genre_res.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class GenreDatabse {
  static const _databaseName = "Database.db";
  static const _databaseVersion = 1;
  static const table = "Genre";
  static const columnId = "_id";
  static const id = "id";
  static const name = "name";
  static const genre = "genre";

  GenreDatabse._();

  static final GenreDatabse instance = GenreDatabse._();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  /// INITIALIZING DATABASE
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // Future _onCreate(Database db, int version) async {
  //   await db.execute('''
  //         CREATE TABLE $table (
  //           $columnId INTEGER PRIMARY KEY,
  //           $genre TEXT NOT NULL,
  //         )
  //         ''');
  // }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $id INTEGER NOT NULL,
            $name TEXT NOT NULL        
          )
          ''');
  }

  Future<int?> insertGenreIntoDb(List<GenresItem> genres) async {
    // var ids;
    // var names;
    // genres.forEach((element) {
    //   ids = element.id;
    //   names = element.name;
    // });

    for(var g in genres){
      final db = await database;
      return await db?.insert(table, {id: g.id, name: g.name});
    }

  }

//   Future<GenreItem> getGenreFromDb() async {
//     final db = await database;
//     var response = await db?.query(table);
//     return List.generate(response.length, (index) => null)
//   //
//   // }
//     GenreItem genre=GenreItem(
//       genres: response.map((e) => Genres.fromJson(e)),
//
//     );
//     return genre;
// }

  Future<GenreItemList> getGenreFromDb2() async {
    final db = await database;
    var response = await db?.query(table);
    // return List.generate(response.length, (index) => GenresItem(
    //   id: response[index]["id"],
    //   name: response[index]["name"]
    // ))
    return GenreItemList(
        genres: response?.map((e) => GenresItem.fromJson(e)).toList());
  }
}
