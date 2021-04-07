import 'package:tugas_uts/bookform.dart';
import 'package:tugas_uts/dbhelper.dart';
import 'package:tugas_uts/bookItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';

class Book extends StatefulWidget {
  
  @override
  BookState createState() => BookState();
}

class BookState extends State<Book> {
  DbHelper dbHelper = DbHelper();
  int count = 0;
  List<BookItem> itemList;

  @override
  //menampilkan data yang sudah diinputkan ketika pertama kali membuka apk
  void initState() {
    super.initState();
    updateListView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book'), //title pada appBar
      ),
      body: Column(
        children: [
          Expanded(
            child: createListView(), //berupa method list untuk menampilkan list data yg dibuat
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add), //icon add untuk menambah buku
        tooltip: 'Add Book',
        onPressed: () async {
          var item = await navigateToEntryForm(context, null); //memanggil fungsi navigate
          if (item != null) {
            //TODO 2 Panggil Fungsi untuk Insert ke DB
            int result = await dbHelper.insertBookItem(item); //memanggil fungsi insert
            if (result > 0) {
              updateListView(); //memanggil fungsi update
            }
          }
        },
      ),
    );
  }

  Future<BookItem> navigateToEntryForm( //digunakan untuk push
      BuildContext context, BookItem bookItem) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return BookEntryForm(bookItem);
        },
      ),
    );
    return result;
  }

  ListView createListView() { //digunakan untuk membuat list data
    TextStyle textStyle = Theme.of(context).textTheme.headline5;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          margin: EdgeInsets.all(8),
          child: ListTile(
            // widget yang akan ditampilkan disebelah kiri title
            leading: CircleAvatar( //digunakan untuk menampilkan icon di list
              backgroundColor: Colors.black,
              child: Icon(Icons.auto_stories), //menampilkan icon buku
            ),
            title: Text(
              this.itemList[index].title, //digunakan untuk menampilkan title di list
              style: textStyle,
            ),
            subtitle: Text(
              this.itemList[index].kategoriName,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
            // widget yang akan ditampilkan setelah title/disebelah kanan title
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit), //icon edit
                  onPressed: () async {
                    var item = await navigateToEntryForm(
                        context, this.itemList[index]);
                    //TODO 4 Panggil Fungsi untuk Edit data
                    if (item != null) editItem(item); //memanggil fungsi edit item
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete), //icon delete
                  onPressed: () async {
                    //TODO 3 Panggil Fungsi untuk Delete dari DB berdasarkan Item
                    deleteItem(itemList[index]); //memanggil fungsi delete item
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  //delete Item
  void deleteItem(BookItem object) async { //digunakan untuk mendelet item
    int result = await dbHelper.deleteBookItem(object.id);
    if (result > 0) {
      updateListView();
    }
  }

  //edit data
  void editItem(BookItem object) async { //digunakan untuk edit data
    int result = await dbHelper.updateBookItem(object);
    if (result > 0) {
      updateListView();
    }
  }

  //update List item
  void updateListView() { //digunakan untuk update list ketika ada perubahan
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      //TODO 1 Select data dari DB
      Future<List<BookItem>> itemListFuture = dbHelper.getBookItemList(); //digunakan untuk menampilkan data
      itemListFuture.then((itemList) {
        setState(() {
          this.itemList = itemList;
          this.count = itemList.length;
        });
      });
    });
  }
}