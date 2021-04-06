import 'dart:io';
import 'dart:async';
import 'package:tugas_uts/bookItem.dart';
import 'package:tugas_uts/kategoriItem.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static DbHelper _dbHelper;
  static Database _database;
  DbHelper._createObject();

  Future<Database> initDb() async {
    //menentukan nama database dan lokasi yg dibuat
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'daftarBuku.db';

    //create, read databases
    var daftarBukuDatabase =
        openDatabase(path, version: 1, onCreate: _createDb);
    //mengembalikan nilai object sebagai hasil dari fungsinya
    return daftarBukuDatabase;
  }

  // untuk membuat tabel pada database
  void _createDb(Database db, int version) async {
    var batchTemp = db.batch();
    // tabel kategoriItem
    await batchTemp.execute('''CREATE TABLE kategoriItem (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT)''');
    // tabel bookItem
    await batchTemp.execute('''CREATE TABLE bookItem(
          id INTEGER PRIMARY KEY AUTOINCREMENT, 
          title TEXT, 
          author TEXT,
          desc TEXT,
          kategoriId INTEGER, 
          FOREIGN KEY (kategoriId) REFERENCES kategoriItem(id))''');
    batchTemp.commit();
  }

  //select data tabel kategoriItem
  Future<List<Map<String, dynamic>>> selectKategoriItem() async {
    Database db = await this.initDb();
    var mapList = await db.query('kategoriItem', orderBy: 'name');
    return mapList;
  }

  //select data tabel bookItem
  Future<List<Map<String, dynamic>>> selectBookItem() async {
    Database db = await this.initDb();
    var mapList = await db.query('bookItem', orderBy: 'title');
    return mapList;
  }

  // insert data tabel KategoriItem
  Future<int> insertKategoriItem(KategoriItem object) async {
    Database db = await this.initDb();
    int count = await db.insert('kategoriItem', object.toMap());
    return count;
  }

  // insert data tabel bookItem
  Future<int> insertBookItem(BookItem object) async {
    Database db = await this.initDb();
    int count = await db.insert('bookItem', object.toMap());
    return count;
  }

  //update data tabel kategoriItem
  Future<int> updateKategoriItem(KategoriItem object) async {
    Database db = await this.initDb();
    int count = await db.update('kategoriItem', object.toMap(),
        where: 'id=?', whereArgs: [object.id]);
    return count;
  }

  //update data tabel bookItem
  Future<int> updateBookItem(BookItem object) async {
    Database db = await this.initDb();
    int count = await db.update('bookItem', object.toMap(),
        where: 'id=?', whereArgs: [object.id]);
    return count;
  }

  //delete data tabel kategoriItem
  Future<int> deleteKategoriItem(int id) async {
    Database db = await this.initDb();
    int count = await db.delete('kategoriItem', where: 'id=?', whereArgs: [id]);
    return count;
  }

  //delete data tabel bookItem
  Future<int> deleteBookItem(int id) async {
    Database db = await this.initDb();
    int count = await db.delete('bookItem', where: 'id=?', whereArgs: [id]);
    return count;
  }

  Future<List<KategoriItem>> getKategoriItemList() async {
    var itemMapList = await selectKategoriItem();
    int count = itemMapList.length;
    List<KategoriItem> itemList = List<KategoriItem>();
    for (int i = 0; i < count; i++) {
      itemList.add(KategoriItem.fromMap(itemMapList[i]));
    }
    return itemList;
  }

  Future<List<BookItem>> getBookItemList() async {
    var itemMapList = await selectBookItem();
    int count = itemMapList.length;
    List<BookItem> itemList = List<BookItem>();
    for (int i = 0; i < count; i++) {
      itemList.add(BookItem.fromMap(itemMapList[i]));
    }
    return itemList;
  }



  factory DbHelper() {
    if (_dbHelper == null) {
      _dbHelper = DbHelper._createObject();
    }
    return _dbHelper;
  }
  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }
    return _database;
  }
}