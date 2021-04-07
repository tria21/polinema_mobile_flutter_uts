import 'package:tugas_uts/kategoriform.dart';
import 'package:tugas_uts/dbhelper.dart';
import 'package:tugas_uts/kategoriItem.dart';
import 'package:tugas_uts/book.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class Kategori extends StatefulWidget {
  @override
  KategoriState createState() => KategoriState();
}

class KategoriState extends State<Kategori> {
  DbHelper dbHelper = DbHelper();
  int count = 0;
  List<KategoriItem> itemList;

  @override
  // untuk menampilkan data yang sudah diinputkan ketika pertama kali apk dibuka
  void initState() {
    super.initState();
    updateListView();
  }

  @override
  Widget build(BuildContext context) {
    if (itemList == null) {
      itemList = List<KategoriItem>();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Kategori'), //title pada appbar
      ),
      body: Column(
        children: [
          Expanded(
            child: createListView(), //memanggil fungsi createlist
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: 'Add Kategori',
        onPressed: () async {
          var item = await navigateToEntryForm(context, null); //memanggil fungsi navigate form
          if (item != null) {
            //TODO 2 Panggil Fungsi untuk Insert ke DB
            int result = await dbHelper.insertKategoriItem(item); //memanggil fungsi insert
            if (result > 0) {
              updateListView(); //memanggil fungsi update list
            }
          }
        },
      ),
    );
  }

  Future<KategoriItem> navigateToEntryForm( //digunakan untuk push data
      BuildContext context, KategoriItem kategoriItem) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return KategoriEntryForm(kategoriItem);
        },
      ),
    );
    return result;
  }

  ListView createListView() { //digunakan untuk membuat list
    TextStyle textStyle = Theme.of(context).textTheme.headline5;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          margin: EdgeInsets.all(8),
          child: ListTile(
            // widget yang akan menampilkan sebelum title
            leading: CircleAvatar(
              backgroundColor: Colors.black,
              child: Icon(Icons.category), //digunakan untuk menampilkan icon kategori
            ),
            title: Text(
              this.itemList[index].name,
              style: textStyle,
            ),
            // widget yang akan menampilkan setelah title
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit), //icon edit
                  onPressed: () async {
                    var item = await navigateToEntryForm(
                        context, this.itemList[index]);
                    //TODO 4 Panggil Fungsi untuk Edit data
                    if (item != null) editItem(item); //memanggil fungsi edit data
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete), //icon delete
                  onPressed: () async {
                    //TODO 3 Panggil Fungsi untuk Delete dari DB berdasarkan Item
                    deleteItem(itemList[index]); //memanggil fungsi delete
                  },
                ),
              ],
            ),
            onTap: () async {
              // Navigator.pushNamed(context, '/item');
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Book()),
              );
            },
          ),
        );
      },
    );
  }

  //delete Item
  void deleteItem(KategoriItem object) async { //digunakan untuk delete item
    int result = await dbHelper.deleteKategoriItem(object.id);
    if (result > 0) {
      updateListView();
    }
  }

  //edit data
  void editItem(KategoriItem object) async { //digunakan untuk edit item
    int result = await dbHelper.updateKategoriItem(object);
    if (result > 0) {
      updateListView();
    }
  }

  //update List item
  void updateListView() { //digunakan untuk update list ketika ada perubahan data
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      //TODO 1 Select data dari DB
      Future<List<KategoriItem>> itemListFuture = dbHelper.getKategoriItemList();
      itemListFuture.then((itemList) {
        setState(() {
          this.itemList = itemList;
          this.count = itemList.length;
        });
      });
    });
  }
}