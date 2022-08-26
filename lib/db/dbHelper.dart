import 'package:intl/date_symbol_data_local.dart';
import 'package:kelime/models/word.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';


class DbHelper 
{

  String tblWords = "Words";
  String colId = "Id";
  String colEng = "Eng";
  String colTr = "Tr";
  String colCate = "Cate";
  static final DbHelper _dbHelper = DbHelper._internal();

  DbHelper._internal();

  factory DbHelper()
  {
    return _dbHelper;
  }

  static Database _db;

  Future<Database> get db async 
  {
    if(_db==null)
    {
      _db = await initializeDb();
    }
    
    return _db;
  }

  Future<Database> initializeDb() async
  {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "word.db";

    var dbEtrade = await openDatabase(path,version:1,onCreate: _createDb);
    return dbEtrade;
  }

  void _createDb(Database db,int version) async
  {
    await db.execute("Create table $tblWords($colId integer primary key,$colEng text,$colTr text , $colCate text)");
  
  }

  Future<int> insert(Word word) async
  {
    Database db = await this.db;

    var result =await db.insert(tblWords, word.toMap());
    return result;
  }

  Future<int> update(Word word) async
  {
    Database db = await this.db;

    var result =await db.update(tblWords, word.toMap(),where : "$colId = ?", whereArgs: [word.id]);
    return result;
  }

  
  Future<int> delete() async
  {
    Database db = await this.db;

    var result =await db.rawDelete("Delete from $tblWords");
    return result;
  }

  Future<List> getProducts() async
  {
     Database db = await this.db;

    var result =await db.rawQuery("Select * from $tblWords");
    //result.forEach((row) => print(row));
    return result;
  }
  Future<List> cateWords(String cates) async
  {
    print(cates);
     Database db = await this.db;
//rawQuery("SELECT id, name FROM people WHERE name = ? AND id = ?", new String[] {"David", "2"});
   var result =await db.rawQuery("Select $colEng,$colTr from $tblWords where $colCate = ?", [cates+" "]);
   //var result =await db.query(tblWords,where: "$colCate = ?" ,whereArgs: [cates]);
    //result.forEach((row) => print(row));
    return result;
  }
  Future<List> arananWords(String cates) async
  {
    print(cates);
     Database db = await this.db;
//rawQuery("SELECT id, name FROM people WHERE name = ? AND id = ?", new String[] {"David", "2"});
   var result =await db.rawQuery("Select $colEng,$colTr from $tblWords where $colEng LIKE '%$cates%';");
   //var result =await db.query(tblWords,where: "$colCate = ?" ,whereArgs: [cates]);
    //result.forEach((row) => print(row));
    return result;
  }
}
