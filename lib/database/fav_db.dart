import 'dart:convert';
import 'dart:io';
import 'package:goldenmovie/model/fav_item_list.dart';
import 'package:goldenmovie/model/movie_detail_item.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class CartDataBase {
  static const _databaseName = "Database.db";
  static const _databaseVersion = 1;
  static const table = "Fav";
  static const columnId = '_id';
  static const genres = "genres";
  static const posterPath = "posterPath";
  static const releaseDate = "releaseDate";
  static const title = "title";
  static const voteAverage = "voteAverage";
  static const voteCount = "voteCount";

  CartDataBase._();

  static final CartDataBase instance = CartDataBase._();
  static Database? _database;

  /// CHECKING DATABASE IS NULL OR NOT
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

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $genres TEXT NOT NULL,          
            $posterPath  TEXT NOT NULL,
            $releaseDate  TEXT NOT NULL,
            $title  TEXT NOT NULL,
            $voteAverage DOUBLE,
            $voteCount INTEGER
          )
          ''');
  }

  Future<int?> insertFavItems(MovieDetailItem movie) async {
    Map<String, dynamic> row = {
      title: movie.title,
      posterPath: movie.posterPath,
      genres: jsonEncode(movie.genres),
      releaseDate: movie.releaseDate,
      voteCount: movie.voteCount,
      voteAverage: movie.voteAverage,
    };
    final db = await database;
    var raw = await db?.insert("Fav", row
        // conflictAlgorithm: ConflictAlgorithm.replace,
        );
    return raw;
  }

  Future<FavItemList> getFavItems() async {
    final db = await database;
    var response = await db?.query("Fav");

    FavItemList? movie = FavItemList(
        movie: response?.map((e) => MovieDetailItem.fromJson(e)).toList());
    return movie;
  }
}
